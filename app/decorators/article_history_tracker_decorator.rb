class ArticleHistoryTrackerDecorator < ApplicationDecorator
  delegate :id, :modifier_id

  def author
    object.modifier_fields['nickname']
  end

  def title
    object.original['title']
  end

  def updated_at
    object.updated_at.strftime("%a %m/%d/%y")
  end

  def changes
    object.tracked_edits.size
  end
end
