class ArticleDecorator < ApplicationDecorator
  delegate :id, :slug, :body, :to_key, :theme, :chronology, :author_id, :location, :comment_count, :share_count, :images, :videos, :published?, :locked?

  decorates_association :history_tracks
  decorates_association :links
  decorates_association :locations

  def created_at(format = :short)
    l(object.created_at, format: format)
  end

  def updated_at(format = :short)
    l(object.updated_at, format: format)
  end

  def author
    object.author_fields['nickname'] || t('user.unknown')
  end

  def author_avatar
    object.author.avatar_url
  end

  def history
    object.history_tracks.count
  end

  def theme
    object.theme_fields["title"]
  end

  def theme_icon
    asset_path('map_icons/' << theme_slug << '.png')
  end

  def theme_picto
    asset_path('themes/' << theme_slug << '.png')
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
      object.tags_array.collect { |tag| tag_link(tag) }.join.html_safe
    else
      h.content_tag(:span, t('none'), class: "label label-warning")
    end
  end

  def display_coordinates
    if object.locations.any?
      object.locations.collect do |l|
        h.content_tag(:div, "", class: "location", :data => {
          :latlng => l.coordinates,
          :title    => to_model.title,
          :uri    => to_model.url,
          :theme    => to_model.theme_icon
        })
      end.join.html_safe
    end
  end

  def display_slug
    truncate(object.slug, length: 20)
  end

  def summary
    linkLevel = 1
    parentLevel = 1;
    heads = Nokogiri::HTML(object.body).css('h1, h2, h3, h4, h5, h6').sort()
    h.content_tag(:ul) do
      heads.reject { |h| h.text.empty? }.collect do |head|
        className = "h%s" % [head.name[1]]
        if head.name[1] == "5"
          currentLevelLabel = " %s. " % [linkLevel]
          linkLevel = linkLevel + 1
        else
          linkLevel = 1
          currentLevelLabel = " %s. " % [parentLevel]
          parentLevel = parentLevel + 1
        end
        head_link = object.slug << '#' << head
        link = '%s <a href="%s" data-level="%s">%s</a>' % [currentLevelLabel, head_link, head.name[1], head.text]
        h.content_tag(:li, raw(link), class: className)
      end.join.html_safe
    end unless heads.empty?
  end

  def title(truncate = nil)
    truncate.nil? ? object.title : object.title.truncate(truncate)
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
    has_image? ? object.images.first.article_image_url(:thumb) : ActionController::Base.helpers.asset_path("article/default.png")
  end

  def has_image?
    object.images.any?
  end

  def featured_images
    images = object.images.take(4)
    images.collect do |img|
      featured_image('col-md-3 col-centered', img.article_image_url(:thumb), img.article_image_url)
    end.join.html_safe
  end

  def images_count
    object.images.count
  end

  def videos_count
    object.videos.count
  end

  private

  def featured_image(image_class, image_url, image_full_url)
    h.content_tag(:div, class: image_class) do
      h.link_to(image_full_url, target: '_blank') do
        h.image_tag(image_url)
      end
    end
  end

  def tag_link(tag)
    link_to_tag = link_to(tag, tag_path(tag))
    h.content_tag(:span, link_to_tag, class: "label label-normal tag")
  end

  def theme_slug
    # For backward compatibility with non-denormalized modelization
    object.theme_fields["slug"] || object.theme.slug
  end

end
