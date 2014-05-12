class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:feature, :unfeature]

  def index
    articles = Article.desc(:created_at).group_by{|a| a.created_at.strftime("%m/%d/%y")}

    # Decorates articles and make array paginable
    @articles = Kaminari.paginate_array(decorate_articles(articles)).page(params[:page]).per(10)
  end

  def feature
    feature = Feature.find(params[:feature_id])
    feature.articles << @article
    feature.save!

    respond_to do |format|
      format.js {}
    end
  end

  def unfeature
    feature = Feature.find(params[:feature_id])
    feature.articles.delete(@article)

    redirect_to admin_features_path
  end

  private

  def set_article
     @article = Article.find(params[:id])
  end

  def decorate_articles(articles)
    articles.collect{ |a| [a[0], ArticleDecorator.decorate_collection(a[1])] }
  end

end
