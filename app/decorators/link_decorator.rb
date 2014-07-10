class LinkDecorator < ApplicationDecorator

  def url
    h.link_to(link.title, url_for(link.url)) + ' : ' + link.url
  end

end
