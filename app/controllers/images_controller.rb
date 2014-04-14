class ImagesController < ApplicationController
  before_filter        :set_article,   only: [:index, :create]

  def index
    render layout: false
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
