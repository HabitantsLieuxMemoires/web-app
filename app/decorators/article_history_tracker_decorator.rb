class ArticleHistoryTrackerDecorator < ApplicationDecorator
  delegate :id, :modifier_id

  def author
    object.modifier.nickname
  end

  def updated_at(format = :short)
    l(object.updated_at, format: format)
  end

  def changes
    object.tracked_edits.size
  end

  def is_new_image?
    object.image_id.present?
  end
end
