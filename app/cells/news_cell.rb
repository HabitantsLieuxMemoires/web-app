class NewsCell < BaseCell

  def index
    @news = Article.newest.limit(5).decorate
    render
  end

end
