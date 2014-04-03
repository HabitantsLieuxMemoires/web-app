class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def new
  end

  def create
    @user = User.or({nickname: params[:identity]}, {email: params[:identity]}).first

    @user.deliver_reset_password_instructions! if @user

    redirect_to(root_path, :notice => 'Instructions have been sent to your email.')
  end

  def edit
  end

  def update
  end

end
