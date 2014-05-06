class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:feature, :unfeature]

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

end
