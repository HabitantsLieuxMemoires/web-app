class Admin::DashboardController < Admin::BaseController

  def index
    @registrations = User.count
    @articles      = Article.count
    @comments      = Comment.count
    @shares        = 0 #TODO: Implement share counter
  end

end
