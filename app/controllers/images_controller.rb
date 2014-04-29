require 'pp'

class ImagesController < ApplicationController
  before_action        :set_article,   only: [:index, :create, :select]
  skip_before_action   :require_login, only: [:index]

  def index
    @images = @article.images.desc(:created_at)

    render layout: false
  end

  def new
    render layout: false
  end

  def create
    @image = @article.images.create!(image_params)
    @article.save

    #TODO: Add support for validation errors when publishing image

    respond_to do |format|
      format.js
    end
  end

  def select
    render layout: false
  end

  private

  def image_params
    params.require(:image).permit(:title, :article_image, :article_image_cache)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
