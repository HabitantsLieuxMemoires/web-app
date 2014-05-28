class VideosController < ApplicationController
  before_action        :set_article,   only: [:new, :create, :destroy]

  def new
    render layout: false
  end

  #TODO: Add UJS support (js rendering)
  def create
    video = Video.new(video_params)
    @article.videos << video

    if @article.save
      create_activity(video, 'article.add_video')

      redirect_to edit_article_path(@article.slug), notice: t('article.video.added')
    else
      flash[:error] = t('article.video.add_error')
      redirect_to edit_article_path(@article.slug)
    end
  end

  def destroy
    video = @article.videos.find(params[:id])
    if video.destroy
      create_activity(video, 'article.remove_video')

      flash[:notice]  = t('article.video.removed')
    else
      falsh[:error]   = t('article.video.remove_error')
    end

    redirect_to edit_article_path(@article)
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end

  def set_article
    @article = Article.unscoped.find(params[:article_id])
  end

  def create_activity(video, key)
    @article.create_activity key:     key,
                             author:  current_user.nickname,
                             title:   @article.title,
                             url:     video.url
  end

end
