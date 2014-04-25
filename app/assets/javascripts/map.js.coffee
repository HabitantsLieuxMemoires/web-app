#= require leaflet-search.min

mapSettings =
  el:'business-header',
  defaultPosition:[44.857981, -0.530777],
  maxBounds:
    southWest: [44.80254, -0.6439],
    northEast: [44.87327, -0.42984]
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
  currentMarker:null,
  positionPickerActive:false,
  addPosition: (latlng) ->
    debug "New marker added on "+latlng

    # Popup button
    btn = document.createElement 'button'
    btn.innerHTML = '<span class="glyphicon glyphicon-ok"></span> Valider cet emplacement'
    btn.className = 'btn btn-success btn-xs'
    btn.type = 'button'
    btn.onclick = ->
      mapController.disablePositionPicker 'save'

    # Add new marker & destroy previous one
    if mapController.currentMarker?
      mapController.mapInstance.removeLayer mapController.currentMarker
    mapController.currentMarker = new L.marker new L.LatLng(latlng.lat, latlng.lng),
      draggable:true
    .addTo( mapController.mapInstance).bindPopup(btn).openPopup()
    # Marker drag
    mapController.currentMarker.on 'dragend', (e) ->
      debug "Marker moved to "+e.target.getLatLng()
      e.target.openPopup()

  enablePositionPicker: ->
    mapController.positionPickerActive = true
    $('.leaflet-control-search').show()
    # Scroll to top
    $('html, body').animate({ scrollTop: 0 },'slow')

    # Bigger map
    $('#'+mapSettings.el).animate
      'height':'500px'
    ,1000, 'swing', ->
        mapController.mapInstance.invalidateSize()

    # Custom search field
    #$('.leaflet-control-search').appendTo('.leaflet-control-position-picker').removeClass('leaflet-control')

    # Centered on rive droite
    mapController.mapInstance.setZoomAround(new L.LatLng(mapSettings.defaultPosition[0], mapSettings.defaultPosition[1]), 14)
    $('.leaflet-control-position-picker').show();
    # Bind map click to add marker
    mapController.mapInstance.on 'click', (e) ->
      if mapController.positionPickerActive == false
        return
      mapController.addPosition(e.latlng)

  disablePositionPicker: (action) ->
    mapController.positionPickerActive = false
    # Populate GPS field
    if action == 'save'
      gps = mapController.currentMarker.getLatLng()
      $('#article_location').val(gps.lat+', '+gps.lng)
    else
      $('#article_location').val ''
    # Hide position picker
    $('.leaflet-control-position-picker').hide()
    $('.leaflet-control-search').show()
    # Restore map to initial state
    $('#'+mapSettings.el).animate
      'height':mapSettings.originalHeight+'px'
    ,500, 'swing', ->
      mapController.mapInstance.invalidateSize()
      # Scroll back to article
      $('html,body').animate({ scrollTop: $('#article-content').offset().top }, 'slow')
    # Destroy marker
    if mapController.currentMarker?
      mapController.mapInstance.removeLayer mapController.currentMarker

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

      # Map instanciation & settings
      maxBounds = mapSettings.maxBounds;
      maxSW = new L.LatLng maxBounds.southWest[0], maxBounds.southWest[1]
      maxNE = new L.LatLng maxBounds.northEast[0], maxBounds.northEast[1]
      map = new L.Map el,
        maxBounds: new L.LatLngBounds maxSW, maxNE

      # Search plugin
      searchControl = new L.Control.Search({
        url: 'http://nominatim.openstreetmap.org/search?format=json&q={s}',
        jsonpParam: 'json_callback',
        propertyName: 'display_name',
        propertyLoc: ['lat','lon'],
        markerLocation: false,
        circleLocation:false,
        autoType: false,
        autoCollapse: true,
        minLength: 2,
        zoom:14,
        text:'Recherche...',
        textCancel:'Annuler',
        textErr:'Aucun résultat',
        position:'topleft'
      })
      searchControl.on('search_locationfound', (e) ->
        mapController.addPosition(e.latlng)
      )
      map.addControl(searchControl)

      # Base view settings
      tileLayer = new L.TileLayer providerSettings.url,
        attribution: providerSettings.attrib
      map.setView new L.LatLng(defaultPosition[0],defaultPosition[1]),12
      map.addLayer tileLayer
      map.addLayer @markerCluster

      # Position picker
      $('.business-header').append '<div class="leaflet-control-position-picker"><span>Cliquez sur la carte pour choisir un emplacement</span></div>'
      $('.business-header').append '<div class="leaflet-control-position-picker buttons"></div>'
      $('.leaflet-control-position-picker.buttons').append('<button type="button" class="btn btn-default btn-xs search"><span class="glyphicon glyphicon-search"></span> Rechercher un lieu</button></div>')
      $('.leaflet-control-position-picker.buttons').append('<button type="button" class="btn btn-default btn-xs cancel"><span class="glyphicon glyphicon-remove"></span> Annuler</button></div>')
      # Location picket
      $('#bt_fill_location').click (e) ->
        mapController.enablePositionPicker()
        e.preventDefault()
        return false;
      # Search button
      $('.leaflet-control-position-picker button.search').on 'click', (e) ->
        e.preventDefault();
        searchControl._handleSubmit();
        return false;
      # Cancel button
      $('.leaflet-control-position-picker button.cancel').on 'click', (e) ->
        e.preventDefault();
        if mapController.currentMarker?
          mapController.mapInstance.removeLayer mapController.currentMarker
        mapController.disablePositionPicker 'cancel'
        return false;

      # Store map instance
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
    markers = $('.location[data-latlng!=""], #theme-articles .media-heading[data-latlng!=""]')
    debug markers.length + " markers found"
    markers.each ->
      latlng = $(this).data("latlng").split ', '
      mapController.addMarker
        latitude: latlng[0]
        longitude: latlng[1]
        text: $(this).data "title"
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
    text = "<a href=\"#{ data.uri }\">#{ data.text }</a>";
    mapController.markerCluster.addLayer(L.marker([data.latitude, data.longitude]).bindPopup(text))
    mapController.mapInstance.fitBounds mapController.markerCluster.getBounds(),
      padding: [70,70]

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