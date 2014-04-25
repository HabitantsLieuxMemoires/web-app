class ArticlesController < ApplicationController
  skip_before_action   :require_login, only: [:show]
  before_action        :set_article,   only: [:show, :edit, :update]

  layout               'empty',        only: [:new, :edit]

  def new
    @article = Article.new
  end

  def create
    theme = Theme.find(article_params[:theme_id])
    chronology = Chronology.find(article_params[:chronology_id])

    @article = Article.new(article_params)
    @article.theme = theme
    @article.chronology = chronology

    if @article.save
      redirect_to article_path(@article.slug), notice: t('models.article.created')
    else
      flash[:error] = t('models.article.creation_error')
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      redirect_to article_path(@article.slug), :notice => t('models.article.updated')
    else
      flash[:error] = t('models.article.update_error')
      render :edit
    end
  end

  def show
    @article = @article.decorate
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tags, :location, :theme_id, :chronology_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
