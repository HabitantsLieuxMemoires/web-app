class Admin::SharesController < Admin::BaseController

  def index
    @activities = PublicActivity::Activity
                  .where(key: 'article.share')
                  .desc(:created_at)
                  .page(params[:page])
                  .per(20)
  end

end
