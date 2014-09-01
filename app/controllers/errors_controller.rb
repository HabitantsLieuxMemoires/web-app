class ErrorsController < ApplicationController
  skip_before_action :require_login, only: [:error404]

  def error404
    render status: :not_found
  end
end
