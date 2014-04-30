class ArticleDecorator < ApplicationDecorator
  delegate :id, :slug, :title, :body, :to_key, :theme, :chronology, :location

  delegate :title, to: :theme,      prefix: true
  delegate :title, to: :chronology, prefix: true

  def history
    object.history_tracks.count
  end

  def visibility
    h.content_tag(:span, class: "label label-default") do
      object.public? ? t('models.article.public') : t('models.article.private')
    end
  end

  def tags
    if object.tags_array.any?
      object.tags_array.collect { |tag| h.content_tag(:span, tag, class: "label label-primary tag") }.join.html_safe
    else
      h.content_tag(:span, t('none'), class: "label label-warning")
    end
  end

  def display_slug
    truncate(object.slug, length: 20)
  end

  def display_location
    if object.location.blank?
      h.content_tag(:span, class: "label label-warning") do
        t('none')
      end
    else
      object.location.split(',').map { |x| x.to_f.round(4).to_s }.join(', ')
    end
  end

  def summary
    heads = Nokogiri::HTML(object.body).css('h4')
    h.content_tag(:ul) do
      heads.collect do |head|
        concat(content_tag(:li, head.text))
        #TODO: Add support for sub elements
      end
    end
  end

end
