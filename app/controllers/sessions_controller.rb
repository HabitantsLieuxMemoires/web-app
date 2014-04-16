class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    user = login(params[:identity], params[:password], params[:remember_me])
    if user
      redirect_to root_url, notice: t('logged_in')
    else
      flash.now.alert = t('authentication.invalid_credentials')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('logged_out')
  end
end
