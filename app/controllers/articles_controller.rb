class ArticlesController < ApplicationController
  skip_before_action   :require_login, only: [:show]
  before_action        :set_article,   only: [:show, :edit, :update]

  def new
    @article = Article.new
  end

  def create
    theme = Theme.find(article_params[:theme])

    @article = theme.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article.id), notice: t('models.article.created')
    else
      flash[:error] = t('models.article.creation_error')
      render :new
    end
  end

  def edit
    render layout: 'articles/edit'
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to article_path(@article.id), :notice => t('models.article.updated')
    else
      flash[:error] = t('models.article.update_error')
      render :edit
    end
  end

  def show
    render layout: 'articles/show'
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tags, :latitude, :longitude, :theme)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
