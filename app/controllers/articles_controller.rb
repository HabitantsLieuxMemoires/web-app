class ArticlesController < ApplicationController
  include ActionView::Helpers::TextHelper
  skip_before_action   :require_login,              only: [:show, :autocomplete, :search, :share]
  before_action        :set_article,                only: [:show, :share]
  before_action        :set_unpublished_article,    only: [:edit, :update]

  layout               'empty',                     only: [:edit]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      create_activity('article.create')

      redirect_to edit_article_path(@article.slug), notice: t('article.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update_attributes(article_params)
      create_activity('article.update')

      redirect_to article_path(@article.slug), :notice => t('article.updated')
    else
      render :edit, layout: 'empty'
    end
  end

  def show
    @article       = @article.decorate
    @contributors  = get_contributors(@article)
  end

  #TODO: Externalize autocomplete and search in own concern
  def autocomplete
    articles = ArticleDecorator.decorate_collection(Article.search(params[:query], autocomplete: true, limit: 10))

    render json: articles.map{|a| {
      :id => a.slug,
      :title => a.title,
      :author => a.author,
      :thumb => a.image,
      :summary => a.body(70),
      :full_url => a.url }
    }
  end

  def search
    articles = Article.search(
      params[:query],
      fields: [{title: :word_start}],
      misspellings: {distance: 2},
      operator: "or",
      boost: "share_count",
      where: ({
        theme: ([params[:themes]] unless params[:themes].empty?),
        tags:  ([params[:tags]] unless params[:tags].empty?)
      }).reject{ |k,v| v.nil?},
      limit: 20
    )

    @articles = ArticleDecorator.decorate_collection(articles)

    respond_to do |format|
      format.js
      format.html { render '/search/index' }
    end
  end

  def share
    @article.inc(share_count: 1)
    create_activity('article.share')

    respond_to do |format|
      format.json { render json: @article.share_count }
    end
  end

  def tags
    tags = Article.tags

     render json: tags
  end

  private

  def article_params
    params.require(:article).permit(
      :title, :body, :tags, :location, :theme_id, :chronology_id, :public, :locked, :published,
      links_attributes: [:id, :url, :_destroy]
    )
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def set_unpublished_article
    @article = Article.unscoped.find(params[:id])
  end

  def create_activity(key)
    @article.create_activity key:       key,
                             author_id: current_user.id,
                             author:    current_user.nickname,
                             title:     @article.title
  end

  def get_contributors(article)
    # Loading article activities
    activities = PublicActivity::Activity.where(trackable_id: article.id)

    # Mapping for display
    activities
      .map{|a| create_contributor(a.author_id, a.author)}
      .uniq{|a| a.id}
  end

  def create_contributor(id, nickname)
    OpenStruct.new(:id => id, :nickname => nickname)
  end

end
