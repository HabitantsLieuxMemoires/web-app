class ChronologiesCell < BaseCell

  def index
    @chronologies = Chronology.by_articles_count
    render
  end

end
