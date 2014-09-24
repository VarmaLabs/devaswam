class SuperAdmin::SessionsController < SuperAdmin::BaseController

  skip_before_filter :require_super_admin, :except => :sign_out
  before_filter :redirect_if_signed_in, :only => :sign_in

  def sign_in

  end

  ## This method will accept a proc, execute it and render the json
  def create_session

    # Fetching the user data (email / username is case insensitive.)
    @authenticated, @super_admin, @heading, @alert = SuperAdmin.authenticate(params[:login_handle], params[:password])

    if @authenticated
      store_flash_message("#{@heading}: #{@alert}", :success)
      session[:super_admin_id] = @super_admin.id
      redirect_to redirect_url_after_sign_in
    else
      store_flash_message("#{@heading}: #{@alert}", :error)
      redirect_to redirect_url_if_sign_in_fails
    end

  end

  def sign_out

    @heading = translate("authentication.success")
    @alert = translate("authentication.logged_out_successfully")
    store_flash_message("#{@heading}: #{@alert}", :notice)

    # Reseting the auth token for user when he logs out.
    @current_super_admin.update_attribute :auth_token, SecureRandom.hex

    session.delete(:super_admin_id)

    redirect_to redirect_url_after_sign_out

  end

end
