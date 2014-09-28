class SuperAdmin::DeitiesController < SuperAdmin::BaseController

  before_filter :parse_pagination_params, :only=>:index
  before_filter :set_navs

  # GET /deities
  # GET /deities.js
  # GET /deities.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deities }
      format.js {}
    end
  end

  # GET /deities/1
  # GET /deities/1.js
  # GET /deities/1.json
  def show
    ## Creating the deity object
    @deity = Deity.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @deity }
      format.js {}
    end
  end

  # GET /deities/new
  # GET /deities/new.json
  def new
    ## Intitializing the deity object
    @deity = Deity.new

    if params[:temple_id]
      @temple = Temple.find_by_id(params[:temple_id])
      @deity.temple = @temple
    end

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @deity }
      format.js {}
    end
  end

  # GET /deities/1/edit
  def edit
    ## Fetching the deity object
    @deity = Deity.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @deity }
      format.js {}
    end
  end

  # POST /deities
  # POST /deities.js
  # POST /deities.json
  def create
    ## Creating the deity object
    @deity = Deity.new(deity_params)

    if params[:deity] && params[:deity][:temple_id]
      @temple = Temple.find_by_id(params[:deity][:temple_id])
      @deity.temple = @temple
      @deity.trust = @temple.trust
    end

    ## Validating the data
    @deity.valid?

    respond_to do |format|
      if @deity.errors.blank?

        # Saving the deity object
        @deity.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Deity")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_deity_url(@deity), notice: message
        }
        format.json { render json: @deity, status: :created, location: @deity }
        format.js {}
      else

        # Setting the flash message
        message = @deity.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @deity.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /deities/1
  # PUT /deities/1.js
  # PUT /deities/1.json
  def update
    ## Fetching the deity
    @deity = Deity.find(params[:id])

    ## Updating the @deity object with params
    @deity.assign_attributes(deity_params)

    ## Validating the data
    @deity.valid?

    respond_to do |format|
      if @deity.errors.blank?

        # Saving the deity object
        @deity.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Deity")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_deity_url(@deity), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @deity.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @deity.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /deities/1
  # DELETE /deities/1.js
  # DELETE /deities/1.json
  def destroy
    ## Fetching the deity
    @deity = Deity.find(params[:id])

    respond_to do |format|
      ## Destroying the deity
      @deity.destroy
      @deity = Deity.new

      # Fetch the deities to refresh ths list and details box
      get_collections
      @deity = @deities.first if @deities and @deities.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Deity")
      store_flash_message(message, :success)

      format.html {
        redirect_to super_admin_deities_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("Manage Deities")
  end

  def get_collections
    # Fetching the deities
    relation = Deity.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @deities = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @deity object so that we can render the show partial
    @deity = @deities.first unless @deity

    return true

  end

  def deity_params
    params.require(:deity).permit(:name, :description, :temple_id, :trust_id)
  end

end
