class Admin::UsersController < Admin::BaseController
  before_action :set_user,    only: [:warn, :ban]
  before_action :set_article, only: [:warn, :ban]

  def index
    @users = User.desc(:created_at)
      .page(params[:page])
      .decorate
  end

  def warn
    @user.inc(warn_count: 1)

    UserMailer.warn_email(@user, @article).deliver

    redirect_to :back, notice: t('user.warned')
  end

  def ban
    @user.destroy

    UserMailer.ban_email(@user, @article).deliver

    redirect_to :back, notice: t('user.banned')
  end

  def change_role
    user = User.find(params[:user_id])
    role = Hlm::ROLES[params[:role].to_sym]

    if user.update_attribute(:roles, [role])
      redirect_to admin_users_path, notice: t('admin.users.role.changed')
    else
      flash[:error] = t('admin.users.role.change_error')
      render :index
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end
