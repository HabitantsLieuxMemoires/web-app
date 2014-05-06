class FeaturesCell < Cell::Rails

  def index
    @feature = Feature.last
    render
  end

end
