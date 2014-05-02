class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:warn, :ban]

  def warn
    @article = Article.find(params[:article_id])
    @user.inc(warn_count: 1)

    UserMailer.warn_email(@user, @article).deliver

    redirect_to :back, notice: t('models.user.warned')
  end

  def ban
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
