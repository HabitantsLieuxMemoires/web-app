class PublicActivityDecorator < ApplicationDecorator
  delegate :title

  def created_at
    time_ago_in_words(object.created_at)
  end

end
