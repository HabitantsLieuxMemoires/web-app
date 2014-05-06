class ThemesCell < BaseCell

  cache :index, :expires_in => 6.hours

  def index
    @themes = Theme.by_articles_count
    render
  end

end
