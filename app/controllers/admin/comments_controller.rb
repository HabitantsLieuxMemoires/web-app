class Admin::CommentsController < Admin::BaseController

  def index
    @activities = PublicActivity::Activity
                      .where(key: 'comment.create')
                      .desc(:created_at)
                      .page(params[:page])
                      .per(20)
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.destroy
      redirect_to admin_comments_path, notice: t('article.comment.deleted')
    else
      flash[:error] = t('article.comment.delete_error')
      render :index
    end
  end

end
