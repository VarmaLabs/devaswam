class SuperAdmin::HomeController < SuperAdmin::BaseController

  before_filter :require_super_admin
  before_filter :set_navs, :only=>:index

  # GET /
  def index
  end

  private

  def set_navs
    set_nav("Home")
  end

end
