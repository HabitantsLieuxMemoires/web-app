class UserDecorator < ApplicationDecorator
  delegate :id, :nickname, :email

  def created_at
    l(object.created_at)
  end

  def article_count
    h.content_tag(:span, object.article_count, class: "label label-success")
  end

  def comment_count
    h.content_tag(:span, object.comment_count, class: "label label-success")
  end

  def role
    h.content_tag(:span, class: "label label-default") do
      object.roles.empty? ? t('user.role.user') : t( 'user.role.' << object.roles.first)
    end
  end
end
