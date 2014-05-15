class ArticleHistoryTrackerDecorator < ApplicationDecorator
  delegate :id, :modifier_id

  def author
    object.modifier_fields['nickname']
  end

  def title
    object.original['title']
  end

  def updated_at(format = :short)
    l(object.updated_at, format: format)
  end

  def changes
    object.tracked_edits.size
  end
end
