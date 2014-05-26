class Admin::ImagesController < Admin::BaseController
  before_action :set_image, only: [:show, :restore]

  def show
    render layout: false
  end

  def restore
    if @image.restore
      flash[:notice] = t('article.image.restored')
    else
      flash[:error] = t('article.image.restore_error')
    end

    redirect_to(:back)
  end

  private

  def set_image
    @image = Article.find(params[:article_id]).images.unscoped.find(params[:id])
  end

end
