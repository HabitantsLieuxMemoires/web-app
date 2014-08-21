class LocationDecorator < ApplicationDecorator

  def display_coordinates
    object.coordinates.split(',').map { |x| x.to_f.to_s }.join(', ')
  end

  def url
    coordinates = object.coordinates.split(',')
    latitude    = coordinates[0]
    longitude   = coordinates[1]

    # Link to OpenStreetMap
    link = "http://www.openstreetmap.org/?mlat=#{latitude}&mlon=#{longitude}&zoom=12"

    url_for(link)
  end

end
