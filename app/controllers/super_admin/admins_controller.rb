class SuperAdmin::AdminsController < SuperAdmin::BaseController

  before_filter :set_navs, :parse_pagination_params, :only=>:index

  # GET /admins
  # GET /admins.js
  # GET /admins.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admins }
      format.js {}
    end
  end

  # GET /admins/1
  # GET /admins/1.js
  # GET /admins/1.json
  def show
    ## Creating the admin object
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @admin }
      format.js {}
    end
  end

  # GET /admins/new
  # GET /admins/new.json
  def new
    ## Intitializing the admin object
    @admin = Admin.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @admin }
      format.js {}
    end
  end

  # GET /admins/1/edit
  def edit
    ## Fetching the admin object
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @admin }
      format.js {}
    end
  end

  # POST /admins
  # POST /admins.js
  # POST /admins.json
  def create
    ## Creating the admin object
    @admin = Admin.new(admin_params)

    ## Validating the data
    @admin.valid?

    respond_to do |format|
      if @admin.errors.blank?

        # Saving the admin object
        @admin.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Admin")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_admin_url(@admin), notice: message
        }
        format.json { render json: @admin, status: :created, location: @admin }
        format.js {}
      else

        # Setting the flash message
        message = @admin.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.js
  # PUT /admins/1.json
  def update
    ## Fetching the admin
    @admin = Admin.find(params[:id])

    ## Updating the @admin object with params
    @admin.assign_attributes(admin_params)

    ## Validating the data
    @admin.valid?

    respond_to do |format|
      if @admin.errors.blank?

        # Saving the admin object
        @admin.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Admin")
        store_flash_message(message, :success)

        format.html {
          redirect_to super_admin_admin_url(@admin), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @admin.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.js
  # DELETE /admins/1.json
  def destroy
    ## Fetching the admin
    @admin = Admin.find(params[:id])

    respond_to do |format|
      ## Destroying the admin
      @admin.destroy
      @admin = Admin.new

      # Fetch the admins to refresh ths list and details box
      get_collections
      @admin = @admins.first if @admins and @admins.any?

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
    # Fetching the admins
    relation = Admin.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @admins = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @admin object so that we can render the show partial
    @admin = @admins.first unless @admin

    return true

  end

  def admin_params
    params.require(:admin).permit(:name, :username, :status, :email, :phone, :address, :trust_id, :password, :password_confirmation)
  end

end
