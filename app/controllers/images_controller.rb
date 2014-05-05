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
    image = Image.new(image_params)
    @article.images << image

    if @article.save
      redirect_to edit_article_path(@article.slug), notice: t('models.image.uploaded')
    else
      flash[:error] = t('models.image.upload_error')
      redirect_to edit_article_path(@article.slug)
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
