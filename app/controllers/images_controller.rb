class ImagesController < ApplicationController
  before_action        :set_article,   only: [:create, :select, :destroy]

  def new
    render layout: false
  end

  def create
    @image = Image.new(image_params)
    @article.images << @image

    respond_to do |format|
      if @article.save && create_activity(@image, 'article.add_image')
        format.js
      else
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  def select
    render layout: false
  end

  def destroy
    @image = @article.images.find(params[:id])

    respond_to do |format|
      if @image.destroy
        format.js
      else
        format.json { render :json => @image.errors, :status => :unprocessable_entity }
      end
    end
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
