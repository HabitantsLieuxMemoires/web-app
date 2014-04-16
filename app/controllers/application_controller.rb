class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action         :require_login
  prepend_before_action :verify_authenticity_token, :if => :js?

  private

  def not_authenticated
    redirect_to login_url, alert: t('authentication.not_authenticated')
  end

  def js?
    request.format.js?
  end

  def verified_request?
    !protect_against_forgery? || request.head? ||
    form_authenticity_token == params[request_forgery_protection_token] ||
    form_authenticity_token == request.headers['X-CSRF-Token']
  end
end
