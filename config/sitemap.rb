# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.habitantslieuxmemoires.fr"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  add '/contact'
  add '/search'
  add '/pages/about'
end
