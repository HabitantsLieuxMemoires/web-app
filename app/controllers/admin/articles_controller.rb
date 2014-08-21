class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:show, :destroy, :feature, :unfeature]

  def index
    @activities = PublicActivity::Activity
                      .in(key: [
                        'article.update',
                        'article.add_image',
                        'article.remove_image',
                        'article.add_video',
                        'article.remove_video'])
                      .desc(:created_at)
                      .page(params[:page])
                      .per(20)
  end

  def show
    @tracks  = ArticleHistoryTracker.where(association_chain: { 'name' => Article.name, 'id' => @article._id }).decorate
    @article = @article.decorate
  end

  def destroy
    if @article.destroy
      flash[:notice] = t('article.removed')
    else
      flash[:error] = t('article.remove_error')
    end

    redirect_to admin_root_path
  end

  def feature
    feature = Feature.last
    feature.articles << @article
    feature.save!

    @article = @article.decorate

    respond_to do |format|
      format.js {}
    end
  end

  def unfeature
    feature = Feature.last
    feature.articles.delete(@article)

    redirect_to admin_features_path
  end

  private

  def set_article
     @article = Article.find(params[:id])
  end

end
