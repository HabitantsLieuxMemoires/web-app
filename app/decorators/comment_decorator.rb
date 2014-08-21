class CommentDecorator < ApplicationDecorator
  delegate :id, :content, :user_id

  def user
    object.user_fields["nickname"]
  end

  def user_avatar
    object.user_fields["avatar_url"]
  end

  def article
    object.article_fields["title"]
  end

  def article_url
    article_path(object.article_fields["slug"])
  end

  def created_at
    time_ago_in_words(object.created_at)
  end

end
