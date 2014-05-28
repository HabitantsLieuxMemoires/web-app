class Admin::VideosController < Admin::BaseController
  before_action :set_video, only: [:show, :restore]

  def show
    render layout: false
  end

  def restore
    if @video.restore
      flash[:notice] = t('article.video.restored')
    else
      flash[:error] = t('article.video.restore_error')
    end

    redirect_to(:back)
  end

  private

  def set_video
    @video = Article.find(params[:article_id]).videos.unscoped.find(params[:id])
  end

end
