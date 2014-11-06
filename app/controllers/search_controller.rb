class SearchController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @articles ||= []
  end

end
