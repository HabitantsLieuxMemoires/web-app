class ThemesCell < BaseCell

  def index
    @themes = Theme.by_articles_count
    render
  end

end
