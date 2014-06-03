class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
    render layout: 'empty'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user, should_remember=true)
      redirect_to root_url, notice: t('auth.signed_up')
    else
      render :new, layout: 'empty'
    end
  end

  def show
    # Loading activities for current user
    activities = PublicActivity::Activity
      .where(author: @current_user.nickname)
      .in(key: [
        'article.create',
        'article.update',
        'article.add_image',
        'article.remove_image',
        'article.add_video',
        'article.remove_video'])
      .desc(:created_at)
      .group_by(&:trackable_id)

    @articles  = Article.unscoped.in(id: activities.keys).decorate
  end

  private
    def user_params
      params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
    end
end
