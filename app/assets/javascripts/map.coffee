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

window.mapController =
  # Map Initilizator
  init: (providerSettings, el, defaultPosition) ->
    # Already initialized?
    if $('#business-header').hasClass('leaflet-container') == false
      debug "Map:: Initialization..."
      mapSettings.originalHeight = $('#business-header').height()

      # Marker cluster
      @markerCluster = new L.MarkerClusterGroup
        showCoverageOnHover:  false
        spiderfyOnMaxZoom: true
        animateAddingMarkers: true
      map = new L.Map el

      # Map settings & base layers
      tileLayer = new L.TileLayer(providerSettings.url, {attribution: providerSettings.attrib})
      map.setView(new L.LatLng(defaultPosition[0],defaultPosition[1]),12)
      map.addLayer(tileLayer)
      map.addLayer(@markerCluster)

      @mapInstance = map

      # Add height toggle button
      heightControl = L.Control.extend
        options:
          position: 'topright'
        ,
        onAdd: (map) ->
          control= L.DomUtil.create('div', 'heightToggle leaflet-bar')
          control.innerHTML = '<span class="glyphicon glyphicon-minus"></span>'
          control.onclick = mapController.heightToggle
          control

      map.addControl(new heightControl());

    # Refresh markers
    @refresh()

  # Refresh markers (delete all & reload)
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
        uri: $(this).data "uri"

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
    text = "<a href=\"{ data.uri }\">#{ data.text }</a>";
    mapController.markerCluster.addLayer L.marker([data.latitude, data.longitude]).bindPopup(text)
    mapController.mapInstance.fitBounds mapController.markerCluster.getBounds()

  heightToggle: ->
    currentHeight = $('#'+mapSettings.el).height()
    targetHeight = if currentHeight!= mapSettings.originalHeight then mapSettings.originalHeight else mapSettings.originalHeight * 0.3
    $('#'+mapSettings.el).animate
      'height':targetHeight+'px'
    ,500
    $('#'+mapSettings.el).find('.heightToggle span.glyphicon').toggleClass('glyphicon-minus').toggleClass('glyphicon-plus')


# Page (re)loaded ?
$(document).ready -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition
$(document).on 'page:load', -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition

# Bind "map:addMarkers"
$(document).on 'map:addMarkers', mapController.addMarkersHandler
$(document).on 'map:addMarker', mapController.addMarkerHandler
$(document).on 'map:refresh', mapController.refresh