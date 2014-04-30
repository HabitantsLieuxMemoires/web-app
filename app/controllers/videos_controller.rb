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
    @video = @article.videos.create!(video_params)
    @article.save

    #TODO: Add support for validation errors when adding video

    respond_to do |format|
      format.js
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
