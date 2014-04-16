class PasswordResetsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :edit, :update]

  def new
  end

  def create
    @user = User.or({nickname: params[:identity]}, {email: params[:identity]}).first

    @user.deliver_reset_password_instructions! if @user

    redirect_to(root_path, notice: t('password.reset_instructions_sent'))
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]

    if @user.blank?
      not_authenticated
    end
  end

  def update
    @token = params[:user][:token]
    @user = User.load_from_reset_password_token(@token)

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, notice: t('password.updated'))
    else
      render :edit
    end
  end

end
