class TrustAdmin::BaseController < ApplicationController

  before_filter :require_trust_admin
  layout 'trust_admin'

  protected

  def current_trust_admin
    @current_trust_admin ||= TrustAdmin.find_by_id(session[:trust_admin_id])
  end

  def store_session
    session[:trust_admin_id] = @current_trust_admin.id
  end

  def require_trust_admin
    unless current_trust_admin
      @heading = translate("authentication.error")
      @alert = translate("authentication.invalid_token")
      store_flash_message("#{@heading}: #{@alert}", :errors)
      redirect_to trust_admin_sign_in_url
    end
  end

  def redirect_url_if_sign_in_fails
    trust_admin_sign_in_url
  end

  def redirect_url_after_sign_in
    trust_admin_home_url
  end

  def redirect_url_after_sign_out
    trust_admin_sign_in_url
  end

  def redirect_if_signed_in
    redirect_to redirect_url_after_sign_in if current_trust_admin
  end

  def redirect_unless_signed_in
    redirect_to redirect_url_if_sign_in_fails unless current_trust_admin
  end

end
