class FeaturesCell < BaseCell

  def index
    @feature = Feature.last
    @feature = @feature.decorate unless @feature.blank?
    render
  end

end
