class TrustAdmin::OfferingsController < TrustAdmin::BaseController

  before_filter :require_trust_admin, :get_deity
  before_filter :parse_pagination_params, :only=> [:index, :destroy]
  before_filter :set_navs

  # GET /offerings
  # GET /offerings.js
  # GET /offerings.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offerings }
      format.js {}
    end
  end

  # GET /offerings/1
  # GET /offerings/1.js
  # GET /offerings/1.json
  def show
    ## Creating the offering object
    @offering = Offering.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @offering }
      format.js {}
    end
  end

  # GET /offerings/new
  # GET /offerings/new.json
  def new
    ## Intitializing the offering object
    @offering = Offering.new
    set_deity_and_temple

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @offering }
      format.js {}
    end
  end

  # GET /offerings/1/edit
  def edit
    ## Fetching the offering object
    @offering = Offering.find(params[:id])
    set_deity_and_temple

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @offering }
      format.js {}
    end
  end

  # POST /offerings
  # POST /offerings.js
  # POST /offerings.json
  def create
    ## Creating the offering object
    @offering = Offering.new(offering_params)

    set_deity_and_temple

    ## Validating the data
    @offering.valid?

    respond_to do |format|
      if @offering.errors.blank?

        # Saving the offering object
        @offering.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Offering")
        store_flash_message(message, :success)

        format.html {
          redirect_to trust_admin_offering_url(@offering), notice: message
        }
        format.json { render json: @offering, status: :created, location: @offering }
        format.js {}
      else

        # Setting the flash message
        message = @offering.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /offerings/1
  # PUT /offerings/1.js
  # PUT /offerings/1.json
  def update
    ## Fetching the offering
    @offering = Offering.find(params[:id])

    ## Updating the @offering object with params
    @offering.assign_attributes(offering_params)
    set_deity_and_temple

    ## Validating the data
    @offering.valid?

    respond_to do |format|
      if @offering.errors.blank?

        # Saving the offering object
        @offering.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Offering")
        store_flash_message(message, :success)

        format.html {
          redirect_to trust_admin_offering_url(@offering), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @offering.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /offerings/1
  # DELETE /offerings/1.js
  # DELETE /offerings/1.json
  def destroy
    ## Fetching the offering
    @offering = Offering.find(params[:id])
    @deity = @offering.deity

    respond_to do |format|
      ## Destroying the offering
      @offering.destroy

      # Fetch the offerings to refresh ths list and details box
      get_collections

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Offering")
      store_flash_message(message, :success)

      format.html {
        redirect_to trust_admin_offerings_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("Offering")
  end

  def get_collections

    # Fetching the offerings
    relation = @deity.offerings.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @offerings = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @offering object so that we can render the show partial
    @offering = @offerings.first unless @offering

    return true

  end

  def get_deity
    @deity = Deity.find(params[:deity_id]) if params[:deity_id]
  end

  def set_deity_and_temple
    if @deity && @offering
      @offering.deity = @deity
      @offering.temple = @deity.temple
    end
  end

  def offering_params
    params.require(:offering).permit(:name, :deity_id, :temple_id, :price, :devaswam_share, :shanti_share, :kazhakam_share, :notes)
  end

end
