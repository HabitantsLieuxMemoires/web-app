class SessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def new
    @user = User.new
  end

  def create
    user = login(params[:identity], params[:password], params[:remember_me])
    if user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Identity or password was invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end
end
