class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]

  def new
    @user = User.new
    render layout: 'empty'
  end

  def create
    #TODO: Add support for banned users
    #TODO: Add support for validation in associated view
    user = login(params[:identity], params[:password], params[:remember_me])
    if user
      redirect_to root_url
    else
      render :new, layout: 'empty'
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('auth.logged_out')
  end
end
