class ArticleHistoryTrackerDecorator < ApplicationDecorator
  delegate :id, :modifier_id, :article_id, :image_id

  def author
    object.modifier.nickname
  end

  def updated_at(format = :short)
    l(object.updated_at, format: format)
  end

  def changes
    object.tracked_edits.size
  end

  def is_added_image?
    object.image_id.present? && object.action == 'create'
  end

  def is_removed_image?
    object.image_id.present? && object.action == 'destroy'
  end
end
