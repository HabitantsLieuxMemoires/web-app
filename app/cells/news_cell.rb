class NewsCell < Cell::Rails

  def index
    @news = Article.newest
    render
  end

end
