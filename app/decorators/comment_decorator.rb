class CommentDecorator < ApplicationDecorator
  delegate :content

  def user
    object.user_fields["nickname"]
  end

  def created_at
    time_ago_in_words(object.created_at)
  end

end
