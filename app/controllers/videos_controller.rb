class VideosController < ApplicationController
  before_action        :set_article,   only: [:new, :create, :destroy]

  def new
    render layout: false
  end

  def create
    @video = Video.new(video_params)
    @article.videos << @video

    respond_to do |format|
      if @article.save && create_activity(@video, 'article.add_video')
        format.js
      else
        format.json { render :json => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @video = @article.videos.find(params[:id])

    respond_to do |format|
      if @video.destroy
        format.js
      else
        format.json { render :json => @video.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :url)
  end

  def set_article
    @article = Article.unscoped.find(params[:article_id])
  end

  def create_activity(video, key)
    @article.create_activity key:       key,
                             author_id: current_user.id,
                             author:    current_user.nickname,
                             title:     @article.title,
                             url:       video.url
  end

end
