class LinkDecorator < ApplicationDecorator

  def url
    h.link_to(link.title, url_for(link.url), alt: link.title, target: '_blank') + ' : ' + link.url
  end

end
