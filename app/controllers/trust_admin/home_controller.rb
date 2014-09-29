class TrustAdmin::HomeController < TrustAdmin::BaseController

  before_filter :require_trust_admin
  before_filter :set_navs, :only=>:index

  # GET /
  def index
  end

  private

  def set_navs
    set_nav("Home")
  end

end
