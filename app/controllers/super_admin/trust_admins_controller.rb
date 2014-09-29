class SuperAdmin::TrustAdminsController < SuperAdmin::BaseController

  before_filter :parse_pagination_params, :only=>:index
  before_filter :set_navs

  # GET /trust_admins
  # GET /trust_admins.js
  # GET /trust_admins.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trust_admins }
      format.js {}
    end
  end

  # GET /trust_admins/1
  # GET /trust_admins/1.js
  # GET /trust_admins/1.json
  def show
    ## Creating the trust admin object
    @trust_admin = TrustAdmin.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust_admin }
      format.js {}
    end
  end

  # GET /trust_admins/new
  # GET /trust_admins/new.json
  def new
    ## Intitializing the trust admin object
    @trust_admin = TrustAdmin.new
    if params[:trust_id]
      @trust = Trust.find_by_id(params[:trust_id])
      @trust_admin.trust = @trust
    end

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust_admin }
      format.js {}
    end
  end

  # GET /trust_admins/1/edit
  def edit
    ## Fetching the trust admin object
    @trust_admin = TrustAdmin.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @trust_admin }
      format.js {}
    end
  end

  # POST /trust_admins
  # POST /trust_admins.js
  # POST /trust_admins.json
  def create
    ## Creating the trust admin object
    @trust_admin = TrustAdmin.new(admin_params)

    ## Validating the data
    @trust_admin.valid?

    respond_to do |format|
      if @trust_admin.errors.blank?

        # Saving the trust admin object
        @trust_admin.save
        @trust = @trust_admin.trust

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Admin")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_admin_url(@trust_admin), notice: message
        }
        format.json { render json: @trust_admin, status: :created, location: @trust_admin }
        format.js {}
      else

        # Setting the flash message
        message = @trust_admin.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @trust_admin.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /trust_admins/1
  # PUT /trust_admins/1.js
  # PUT /trust_admins/1.json
  def update
    ## Fetching the trust admin
    @trust_admin = TrustAdmin.find(params[:id])

    ## Updating the @trust_admin object with params
    @trust_admin.assign_attributes(admin_params)

    ## Validating the data
    @trust_admin.valid?

    respond_to do |format|
      if @trust_admin.errors.blank?

        # Saving the trust admin object
        @trust_admin.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Admin")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_admin_url(@trust_admin), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @trust_admin.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @trust_admin.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /trust_admins/1
  # DELETE /trust_admins/1.js
  # DELETE /trust_admins/1.json
  def destroy
    ## Fetching the trust admin
    @trust_admin = TrustAdmin.find(params[:id])

    respond_to do |format|
      ## Destroying the trust admin
      @trust_admin.destroy
      @trust_admin = TrustAdmin.new

      # Fetch the trust admins to refresh ths list and details box
      get_collections
      @trust_admin = @trust_admins.first if @trust_admins and @trust_admins.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Admin")
      store_flash_message(message, :success)

      format.html {
        redirect_to super_admin_admins_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("Manage Admin")
  end

  def get_collections
    # Fetching the trust admins
    relation = TrustAdmin.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @trust_admins = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @trust_admin object so that we can render the show partial
    @trust_admin = @trust_admins.first unless @trust_admin

    return true

  end

  def admin_params
    params.require(:admin).permit(:name, :username, :status, :email, :phone, :address, :trust_id, :password, :password_confirmation)
  end

end
