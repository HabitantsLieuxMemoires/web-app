mapSettings =
  el:'business-header',
  defaultPosition:[44.857981, -0.530777],
  osmProviders:{
    osm:{
      url:'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      attrib:'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    },
  # For testing purposes only
  # Mapbox is not free and limited to 3 000view/month (1 view = 15 tiles)
    mapbox:{
      url:'https://{s}.tiles.mapbox.com/v3/examples.map-zr0njcqy/{z}/{x}/{y}.png',
      attrib:'Map data © <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
    }
  }

mapController =
  # Map Initilizator
  init: (providerSettings, el, defaultPosition) ->
    if $('#business-header').hasClass('leaflet-container') == false
      debug "Map:: Initialization..."
      @markerCluster = new L.MarkerClusterGroup
        showCoverageOnHover:  false
        spiderfyOnMaxZoom: true
        animateAddingMarkers: true
      map = new L.Map el

      tileLayer = new L.TileLayer(providerSettings.url, {attribution: providerSettings.attrib});
      map.setView(new L.LatLng(defaultPosition[0],defaultPosition[1]),12);
      map.addLayer(tileLayer);
      map.addLayer(@markerCluster);
    @refresh()

  refresh: ->
    mapController.deleteMarkers()
    mapController.loadMarkers()

  # Load all markers contained into the current page
  loadMarkers: ->
    debug "Loading markers from the current page"
    markers = $('article[data-latitude]')
    debug markers.length + " markers found"
    markers.each ->
      mapController.addMarker
        latitude: $(this).data "latitude"
        longitude: $(this).data "longitude"
        text: $(this).data "text"

  # Erase all markers
  deleteMarkers: ->
    debug 'Map:: Deleting all markers'
    @markerCluster.clearLayers();

  # Add Marker Handlers
  addMarkersHandler: (e, dataArr) ->
    debug 'Map:: New data'
    if dataArr? and dataArr.length > 0
      for data in dataArr
        mapController.addMarker(data)
  addMarkerHandler: (e, data) ->
    mapController.addMarker(data)
  addMarker: (data) ->
    debug data
    mapController.markerCluster.addLayer L.marker([data.latitude, data.longitude]).bindPopup(data.text)
    #.addTo(mapController.layerGroup)

# Page (re)loaded ?
$(document).ready -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition
$(document).on 'page:load', -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition

# Bind "map:addMarkers"
$(document).on 'map:addMarkers', mapController.addMarkersHandler
$(document).on 'map:addMarker', mapController.addMarkerHandler
$(document).on 'map:refresh', mapController.refresh