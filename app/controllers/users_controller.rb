class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user, should_remember=true)
      redirect_to root_url, :notice => "Signed in!"
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
    end
end
