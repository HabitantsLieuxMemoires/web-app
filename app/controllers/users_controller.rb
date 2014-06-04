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

    # Loading articles/comments for current user
    articles_count = Article.where(author_id: @current_user.id).count
    comments_count = Comment.where(user_id: @current_user.id).count

    @articles  = Article.unscoped.in(id: activities.keys).decorate
    @profile   = { :articles => articles_count, :contributions => activities.count, :comments => comments_count }
  end

  def change_password
    change_password = ChangePassword.new(password_params)
    if change_password.valid?
      @current_user.password_confirmation = change_password.password_confirmation
      @current_user.change_password!(change_password.password)

      flash[:notice] = t('password.updated')
    else
      flash[:error]  = t('password.update_error')
    end

    redirect_to profile_path
  end

  def change_avatar
    avatar = Avatar.new(avatar_params)
    if avatar.valid? && @current_user.update_attribute(:avatar, avatar.avatar)
      flash[:notice] = t('profile.avatar.changed')
    else
      flash[:error] = t('profile.avatar.change_error')
    end

    redirect_to profile_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
    end

    def password_params
      params.permit(:password, :password_confirmation)
    end

    def avatar_params
      params.permit(:avatar, :avatar_cache)
    end
end
