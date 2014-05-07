class CommentsController < ApplicationController
  before_action        :set_article,   only: [:index, :create]
  skip_before_action   :require_login, only: [:index]

  def index
    @comments = @article.comments
      .desc(:created_at)
      .page(params[:page])
      .per(10)
      .decorate()

    render layout: false
  end

  def new
    render layout: false
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.article  = @article
    @comment.user     = current_user

    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      #TODO: Handling validation errors (redirect does not work in js format)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
