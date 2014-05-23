class Admin::TracksController < Admin::BaseController
  before_action :set_track, only: [:show, :image]

  def show
    render layout: false
  end

  def image
    @image = Article.find(@track.article_id).images.find(@track.image_id)

    render layout: false
  end

  private

  def set_track
    @track = ArticleHistoryTracker.find(params[:id])
  end

end
