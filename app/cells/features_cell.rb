class FeaturesCell < BaseCell

  def index
    @feature = Feature.last
    render
  end

end
