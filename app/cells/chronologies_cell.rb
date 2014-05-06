class ChronologiesCell < BaseCell

  cache :index, :expires_in => 6.hours

  def index
    @chronologies = Chronology.by_articles_count
    render
  end

end
