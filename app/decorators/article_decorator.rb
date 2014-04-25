class ArticleDecorator < ApplicationDecorator
  delegate :id, :slug, :title, :body, :to_key, :theme, :chronology, :location

  delegate :title, to: :theme,      prefix: true
  delegate :title, to: :chronology, prefix: true

  def tags
    if object.tags_array.any?
      object.tags_array.each do |t|
        h.content_tag(:span, class: "label label-warning") do
          t
        end
      end
    else
      h.content_tag(:span, class: "label label-warning") do
        t('none')
      end
    end
  end

  def history
    object.history_tracks.count
  end

  def visibility
    h.content_tag(:span, class: "label label-default") do
      object.public? ? t('models.article.public') : t('models.article.private')
    end
  end

  def display_location
    object.location.blank? ? t('none') : object.location
  end

end
