module Admin::UsersHelper

  def options_for_user_role
    [
      [t('user.role.admin'), 'admin'],
      [t('user.role.moderator'), 'moderator'],
      [t('user.role.user'), 'user']
    ]
  end

end
