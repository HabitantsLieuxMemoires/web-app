class Admin::CommentsController < Admin::BaseController

  def index
    comments = Comment.desc(:created_at).group_by{|c| c.created_at.strftime("%m/%d/%y")}

    # Decorates comments and make array paginable
    @comments = Kaminari.paginate_array(decorate_comments(comments)).page(params[:page]).per(10)
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

  private

  def decorate_comments(comments)
    comments.collect{ |c| [c[0], CommentDecorator.decorate_collection(c[1])] }
  end

end
