class ArticleHistoryTrackerDecorator < ApplicationDecorator
  delegate :id

  def user
    object.modifier.blank? ? t('unknown') : object.modifier.nickname
  end

  def updated_at
    object.updated_at.strftime("%a %m/%d/%y")
  end

  def changes
    object.tracked_edits.size
  end
end
