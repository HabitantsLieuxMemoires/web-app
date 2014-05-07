class ThemesController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action      :set_theme,     only: [:show]

  def show
    @articles = @theme.articles
                      .most_shared
                      .page(params[:page])
                      .decorate
  end

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end
end
