class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:feature, :unfeature]

  def index
    @activities = PublicActivity::Activity
                      .in(key: ['article.update', 'article.add_image', 'article.remove_image'])
                      .desc(:created_at)
                      .page(params[:page])
                      .per(20)
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

  def decorate_updates(updates)
    updates.collect{ |u| [u[0], ArticleHistoryTrackerDecorator.decorate_collection(u[1])] }
  end

end
