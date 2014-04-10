class CommentsController < ApplicationController
  before_filter        :set_article,   only: [:create]

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @comment = @article.comments.create!(comment_params)
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
