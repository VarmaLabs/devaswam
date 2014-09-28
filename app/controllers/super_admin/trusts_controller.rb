class SuperAdmin::TrustsController < SuperAdmin::BaseController

  before_filter :parse_pagination_params, :only=>:index
  before_filter :set_navs

  # GET /trusts
  # GET /trusts.js
  # GET /trusts.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trusts }
      format.js {}
    end
  end

  # GET /trusts/1
  # GET /trusts/1.js
  # GET /trusts/1.json
  def show
    ## Creating the trust object
    @trust = Trust.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust }
      format.js {}
    end
  end

  # GET /trusts/new
  # GET /trusts/new.json
  def new
    ## Intitializing the trust object
    @trust = Trust.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust }
      format.js {}
    end
  end

  # GET /trusts/1/edit
  def edit
    ## Fetching the trust object
    @trust = Trust.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust }
      format.js {}
    end
  end

  # POST /trusts
  # POST /trusts.js
  # POST /trusts.json
  def create
    ## Creating the trust object
    @trust = Trust.new(trust_params)

    ## Validating the data
    @trust.valid?

    respond_to do |format|
      if @trust.errors.blank?

        # Saving the trust object
        @trust.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Trust")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_trust_url(@trust), notice: message
        }
        format.json { render json: @trust, status: :created, location: @trust }
        format.js {}
      else

        # Setting the flash message
        message = @trust.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @trust.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /trusts/1
  # PUT /trusts/1.js
  # PUT /trusts/1.json
  def update
    ## Fetching the trust
    @trust = Trust.find(params[:id])

    ## Updating the @trust object with params
    @trust.assign_attributes(trust_params)

    ## Validating the data
    @trust.valid?

    respond_to do |format|
      if @trust.errors.blank?

        # Saving the trust object
        @trust.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Trust")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_trust_url(@trust), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @trust.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @trust.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /trusts/1
  # DELETE /trusts/1.js
  # DELETE /trusts/1.json
  def destroy
    ## Fetching the trust
    @trust = Trust.find(params[:id])

    respond_to do |format|
      ## Destroying the trust
      @trust.destroy
      @trust = Trust.new

      # Fetch the trusts to refresh ths list and details box
      get_collections
      @trust = @trusts.first if @trusts and @trusts.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Trust")
      store_flash_message(message, :success)

      format.html {
        redirect_to super_admin_trusts_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("Manage Trusts")
  end

  def get_collections
    # Fetching the trusts
    relation = Trust.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @trusts = relation.order("created_at asc").page(@current_page).per(@per_page)

    ## Initializing the @trust object so that we can render the show partial
    @trust = @trusts.first unless @trust

    return true

  end

  def trust_params
    params.require(:trust).permit(:name, :status, :email, :phone, :address, :description)
  end

end
