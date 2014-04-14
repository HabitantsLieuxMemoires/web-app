class ArticlesController < ApplicationController
  skip_before_filter   :require_login, only: [:show]
  before_filter        :set_article,   only: [:show, :edit]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article.id), :notice => t('models.article.created')
    else
      flash[:error] = t('models.article.creation_error')
      render :new
    end
  end

  def edit
    render :layout => 'articles/edit'
  end

  def show
    render :layout => 'articles/show'
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tags, :latitude, :longitude)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
