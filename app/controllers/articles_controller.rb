class ArticlesController < ApplicationController
  skip_before_action   :require_login, only: [:show, :autocomplete, :search]
  before_action        :set_article,   only: [:show, :update, :share]

  layout               'empty',        only: [:edit]

  def new
  end

  def create
    article = Article.create(article_params.merge(published: false))
    if article
      redirect_to edit_article_path(article.slug), notice: t('article.created')
    else
      flash[:error] = t('article.creation_error')
      render :new
    end
  end

  def edit
    @article = Article.unscoped.find(params[:id])
  end

  def update
    if @article.update_attributes(article_params.merge(published: true))
      redirect_to article_path(@article.slug), :notice => t('article.updated')
    else
      flash[:error] = t('article.update_error')
      render :edit, layout: 'empty'
    end
  end

  def show
    @article = @article.decorate
  end

  #TODO: Externalize autocomplete and search in own concern
  def autocomplete
    articles = Article.search(params[:query], autocomplete: true, limit: 10)
    render json: articles.map{|a| { :id => a.slug, :title => a.title, :full_url => article_url(a) }}
  end

  def search
    articles = Article.search(
      params[:query],
      fields: [{title: :word_start}],
      misspellings: {distance: 2},
      operator: "or",
      boost: "share_count",
      where: ({
        theme: [params[:themes]],
        tags:  ([params[:tags]] unless params[:tags].empty?)
      }).reject{ |k,v| v.nil?},
      limit: 20
    )

    @articles = ArticleDecorator.decorate_collection(articles)

    respond_to do |format|
      format.js
    end
  end

  def share
    @article.inc(share_count: 1)

    respond_to do |format|
      format.json { render json: @article.share_count }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tags, :location, :theme_id, :chronology_id, :public, :locked)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
