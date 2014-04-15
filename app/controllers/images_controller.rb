class ImagesController < ApplicationController
  before_filter        :set_article,   only: [:index, :create]

  def index
    render layout: false
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @image = @article.images.create!(image_params)
    @article.save

    #TODO: Add support for validation errors when publishing image

    redirect_to article_path(@article.id), :notice => t('models.image.uploaded')
  end

  private

  def image_params
    params.require(:image).permit(:title, :article_image, :article_image_cache)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
