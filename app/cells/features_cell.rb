class FeaturesCell < BaseCell

  def index
    @feature = Feature.last.decorate
    render
  end

end
