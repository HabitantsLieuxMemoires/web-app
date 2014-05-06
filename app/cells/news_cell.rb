class NewsCell < BaseCell

  def index
    @news = Article.newest
    render
  end

end
