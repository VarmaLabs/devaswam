class SuperAdmin::BaseController < ApplicationController

  before_filter :require_super_admin
  layout 'super_admin'

  def require_super_admin
  end

end
