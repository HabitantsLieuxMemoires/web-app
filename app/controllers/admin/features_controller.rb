class Admin::FeaturesController < Admin::BaseController
  before_action :set_feature, only: [:edit, :update]

  def index
    feature = Feature.last
    redirect_to feature.blank? ? new_admin_feature_path : edit_admin_feature_path(feature)
  end

  def new
  end

  def create
    if Feature.create(feature_params)
      redirect_to admin_features_path, notice: t('admin.editorial.feature.saved')
    else
      flash[:error] = t('admin.editorial.feature.save_error')
      render :new
    end
  end

  def edit
  end

  def update
    if @feature.update_attributes(feature_params)
      redirect_to admin_features_path, notice: t('admin.editorial.feature.saved')
    else
      flash[:error] = t('admin.editorial.feature.save_error')
      render :index
    end
  end

  private

  def feature_params
    params.require(:feature).permit(:title, :description)
  end

  def set_feature
    @feature = Feature.last.decorate
  end

end
