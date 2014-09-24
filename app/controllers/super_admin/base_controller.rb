class SuperAdmin::BaseController < ApplicationController

  before_filter :require_super_admin
  layout 'super_admin'

  protected

  def current_super_admin
    @current_super_admin = SuperAdmin.find_by_id(session[:super_admin_id])
  end

  def store_session
    session[:super_admin_id] = @current_super_admin.id
  end

  def require_super_admin
    unless current_super_admin
      @heading = translate("authentication.error")
      @alert = translate("authentication.invalid_token")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to super_admin_sign_in_url
    end
  end

  def redirect_url_if_sign_in_fails
    super_admin_sign_in_url
  end

  def redirect_url_after_sign_in
    super_admin_home_url
  end

  def redirect_url_after_sign_out
    super_admin_sign_in_url
  end

  def redirect_if_signed_in
    redirect_to redirect_url_after_sign_in if current_super_admin
  end

  def redirect_unless_signed_in
    redirect_to redirect_url_if_sign_in_fails unless current_super_admin
  end

end
