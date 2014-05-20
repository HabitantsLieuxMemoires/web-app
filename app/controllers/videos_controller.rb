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

  #TODO: Add UJS support (js rendering)
  def create
    video = Video.new(video_params)
    @article.videos << video

    if @article.save
      redirect_to edit_article_path(@article.slug), notice: t('article.video.added')
    else
      flash[:error] = t('article.video.add_error')
      redirect_to edit_article_path(@article.slug)
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end

  def set_article
    @article = Article.unscoped.find(params[:article_id])
  end

end
