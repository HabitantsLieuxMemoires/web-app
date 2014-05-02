class Admin::TracksController < Admin::BaseController

  def show
    @track = ArticleHistoryTracker.find(params[:id])

    render layout: false
  end

end
