class CommentsController < ApplicationController
  before_filter        :set_article,   only: [:create]

  def new
    @comment = Comment.new
    render :layout => false
  end

  def create
    @comment = Comment.new(comment_params[:comment])
    @article.comments << @comment
    @article.save

    #TODO: Add support for validation errors when publishing comment

    respond_to do |format|
        format.js
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
