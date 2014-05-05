class VideosController < ApplicationController
  before_action        :set_article,   only: [:index, :new, :create]
  skip_before_action   :require_login, only: [:index]

  def index
    @videos = @article.videos.desc(:created_at)

    render layout: false
  end

  def new
    render layout: false
  end

  def create
    video = Video.new(video_params)
    @article.videos << video

    if @article.save
      redirect_to edit_article_path(@article.slug), notice: t('models.video.added')
    else
      flash[:error] = t('models.video.add_error')
      redirect_to edit_article_path(@article.slug)
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end
