class ChronologiesCell < Cell::Rails

  cache :index, :expires_in => 6.hours

  def index
    @chronologies = Chronology.by_articles_count
    render
  end

end
