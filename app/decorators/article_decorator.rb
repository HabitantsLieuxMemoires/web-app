class ArticleDecorator < ApplicationDecorator
  delegate :id, :slug, :title, :body, :to_key, :theme, :chronology, :author_id, :location, :comment_count, :share_count, :images, :videos, :published?, :locked?

  decorates_association :history_tracks
  decorates_association :links

  def created_at(format = :short)
    l(object.created_at, format: format)
  end

  def updated_at(format = :short)
    l(object.updated_at, format: format)
  end

  def author
    object.author_fields['nickname'] || t('unknown')
  end

  def history
    object.history_tracks.count
  end

  def theme
    object.theme_fields["title"]
  end

  def chronology
    object.chronology_fields["title"]
  end

  def url
    article_path(object.slug)
  end

  def visibility
    # Remoded class "label label-default"
    h.content_tag(:span, class: " ") do
      object.public? ? t('article.public') : t('article.private')
    end
  end

  def status
    if object.published?
      h.content_tag(:span, class: "label label-default") do
        t('article.published')
      end
    else
      h.content_tag(:span, class: "label label-warning") do
        t('article.unpublished')
      end
    end
  end

  def tags
    if object.tags_array.any?
      object.tags_array.collect { |tag| h.content_tag(:span, tag, class: "label label-normal tag") }.join.html_safe
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
      coordinates = object.location.split(',')
      latitude    = coordinates[0]
      longitude   = coordinates[1]

      # Link to OpenStreetMap
      link       = "http://www.openstreetmap.org/?mlat=#{latitude}&mlon=#{longitude}&zoom=12"
      link_title = coordinates.map { |x| x.to_f.round(4).to_s }.join(', ')

      h.link_to link_title, url_for(link), target: '_blank'
    end
  end

  def summary
    heads = Nokogiri::HTML(object.body).css('h1, h2, h3, h4, h5, h6').sort()
    h.content_tag(:ol) do
      heads.reject { |h| h.text.empty? }.collect do |head|
        link = '<a href="%s" data-level="%s">%s</a>' % [head, head.name[1], head.text]
        h.content_tag(:li, raw(link))
      end.join.html_safe
    end unless heads.empty?
  end

  def body(truncate = nil)
    # Force HTML tag to be prefixed by a space
    # (proper display once tags has been stripped)
    object.body.gsub! '<', ' <'
    body = strip_tags(object.body)
    body.truncate(truncate).html_safe unless truncate.nil?
  end

  def full_body
    raw(object.body)
  end

  def image
    image = object.images.first
    image.nil? ? ActionController::Base.helpers.asset_path("article/default.png") : image.article_image_url(:thumb)
  end

  def featured_images
    images = object.images.take(4)
    images.collect { |img| featured_image('col-md-3 col-centered', img.article_image_url(:thumb)) }.join.html_safe
  end

  def images_count
    object.images.count
  end

  def videos_count
    object.videos.count
  end

  private

  def featured_image(image_class, image_url)
    h.content_tag(:div, class: image_class) do
      h.image_tag(image_url)
    end
  end

end
