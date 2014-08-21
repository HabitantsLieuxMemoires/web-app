class TagsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @tags = Article.tags
    render json: @tags
  end

  def show
    @tag        = params[:id]
    @articles   = Article.tagged_with(@tag).page(params[:page]).decorate
  end

end
