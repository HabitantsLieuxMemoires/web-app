class ImagesController < ApplicationController
  before_action        :set_article,   only: [:create, :select, :destroy]

  def new
    render layout: false
  end

  #TODO: Use UJS capabilities (with js rendering)
  def create
    image = Image.new(image_params)
    @article.images << image

    if @article.save
      create_activity(image, 'article.add_image')

      redirect_to edit_article_path(@article.slug), notice: t('article.image.uploaded')
    else
      flash[:error] = t('article.image.upload_error')
      redirect_to edit_article_path(@article.slug)
    end
  end

  def select
    render layout: false
  end

  def destroy
    image = @article.images.find(params[:id])
    if image.destroy
      create_activity(image, 'article.remove_image')

      flash[:notice]  = t('article.image.removed')
    else
      falsh[:error]   = t('article.image.remove_error')
    end

    redirect_to edit_article_path(@article)
  end

  private

  def image_params
    params.require(:image).permit(:title, :article_image, :article_image_cache)
  end

  def set_article
    @article = Article.unscoped.find(params[:article_id])
  end

  def create_activity(image, key)
    @article.create_activity key:       key,
                             author_id: current_user.id,
                             author:    current_user.nickname,
                             title:     @article.title,
                             url:       image.article_image_url(:thumb)
  end

end
