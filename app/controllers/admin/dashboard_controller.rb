class Admin::DashboardController < Admin::BaseController
  skip_before_action  :require_admin_login
  before_action       :require_moderator_login

  def index
    @registrations = User.count
    @articles      = Article.count
    @comments      = Comment.count
    @shares        = 0 #TODO: Implement share counter
  end

end
