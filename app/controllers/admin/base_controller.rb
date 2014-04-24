class Admin::BaseController < ApplicationController
  before_action :require_admin_login
  layout 'admin'

  private

  def require_admin_login
    redirect_to(root_path) unless current_user.has_role?('admin')
  end
end
