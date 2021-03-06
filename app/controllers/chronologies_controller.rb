class ChronologiesController < ApplicationController
  skip_before_action :require_login,  only: [:show]
  before_action      :set_chronology, only: [:show]

  def show
    @articles = @chronology.articles
                           .most_shared
                           .page(params[:page])
                           .decorate
  end

  private

  def set_chronology
    @chronology = Chronology.find(params[:id])
  end
end
