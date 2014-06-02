class LinkDecorator < ApplicationDecorator

  def url
    h.link_to link.url.truncate(30), url_for(link.url)
  end

end
