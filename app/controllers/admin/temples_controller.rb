class Admin::TemplesController < ApplicationController

  #before_filter :require_user
  #authorize_actions_for Item, :actions => {:index => :delete}
  before_filter :set_navs, :parse_pagination_params, :only=>:index

  # GET /temples
  # GET /temples.js
  # GET /temples.json
  def index

    get_collections

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @temples }
      format.js {}
    end
  end

  # GET /temples/1
  # GET /temples/1.js
  # GET /temples/1.json
  def show
    ## Creating the temple object
    @temple = Temple.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @temple }
      format.js {}
    end
  end

  # GET /temples/new
  # GET /temples/new.json
  def new
    ## Intitializing the temple object
    @temple = Temple.new

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @temple }
      format.js {}
    end
  end

  # GET /temples/1/edit
  def edit
    ## Fetching the temple object
    @temple = Temple.find(params[:id])

    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @temple }
      format.js {}
    end
  end

  # POST /temples
  # POST /temples.js
  # POST /temples.json
  def create
    ## Creating the temple object
    @temple = Temple.new(temple_params)

    ## Validating the data
    @temple.valid?

    respond_to do |format|
      if @temple.errors.blank?

        # Saving the temple object
        @temple.save

        # Setting the flash message
        message = translate("forms.created_successfully", :item => "Temple")
        store_flash_message(message, :success)

        format.html {
          redirect_to admin_temple_url(@temple), notice: message
        }
        format.json { render json: @temple, status: :created, location: @temple }
        format.js {}
      else

        # Setting the flash message
        message = @temple.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html { render action: "new" }
        format.json { render json: @temple.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /temples/1
  # PUT /temples/1.js
  # PUT /temples/1.json
  def update
    ## Fetching the temple
    @temple = Temple.find(params[:id])

    ## Updating the @temple object with params
    @temple.assign_attributes(temple_params)

    ## Validating the data
    @temple.valid?

    respond_to do |format|
      if @temple.errors.blank?

        # Saving the temple object
        @temple.save

        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "Temple")
        store_flash_message(message, :success)

        format.html {
          redirect_to admin_temple_url(@temple), notice: message
        }
        format.json { head :no_content }
        format.js {}

      else

        # Setting the flash message
        message = @temple.errors.full_messages.to_sentence
        store_flash_message(message, :alert)

        format.html {
          render action: "edit"
        }
        format.json { render json: @temple.errors, status: :unprocessable_entity }
        format.js {}

      end
    end
  end

  # DELETE /temples/1
  # DELETE /temples/1.js
  # DELETE /temples/1.json
  def destroy
    ## Fetching the temple
    @temple = Temple.find(params[:id])

    respond_to do |format|
      ## Destroying the temple
      @temple.destroy
      @temple = Temple.new

      # Fetch the temples to refresh ths list and details box
      get_collections
      @temple = @temples.first if @temples and @temples.any?

      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "Temple")
      store_flash_message(message, :success)

      format.html {
        redirect_to admin_temples_url notice: message
      }
      format.json { head :no_content }
      format.js {}

    end
  end

  private

  def set_navs
    set_nav("Temple")
  end

  def get_collections
    # Fetching the temples
    relation = Temple.where("")
    @filters = {}

    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end

    @temples = relation.order("created_at desc").page(@current_page).per(@per_page)

    ## Initializing the @temple object so that we can render the show partial
    @temple = @temples.first unless @temple

    return true

  end

  def temple_params
    params.require(:temple).permit(:name, :description, :trust_id)
  end

end
