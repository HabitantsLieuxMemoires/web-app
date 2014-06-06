class Admin::BaseController < ApplicationController
  before_action :require_admin_login
  layout 'admin'

  protected

  def require_moderator_login
    redirect_to(root_path) unless current_user.has_role?('moderator') || current_user.has_role?('admin')
  end

  def require_admin_login
    redirect_to(root_path) unless current_user.has_role?('admin')
  end

end
