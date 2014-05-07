class PopularsCell < BaseCell

  def index
    @populars = Article.most_shared.limit(6).decorate
    render
  end

end
