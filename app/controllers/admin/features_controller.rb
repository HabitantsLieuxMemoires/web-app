class Admin::FeaturesController < Admin::BaseController
  before_action :set_feature, only: [:index, :update]

  def index
  end

  def update
    if @feature.update_attributes(feature_params)
      redirect_to admin_features_path, notice: t('models.feature.saved')
    else
      flash[:error] = t('model.feature.save_error')
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
