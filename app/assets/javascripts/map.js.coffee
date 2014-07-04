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
  locate: ->
    if Modernizr.geolocation
      mapController.mapInstance.locate
        setView: true
        maxZoom: 13
        minZoom: 13
      mapController.mapInstance.on 'locationerror',
        debug 'Location error'
        # Berk!
        # @todo find a better fix
        cb = ->
          mapController.mapInstance.setZoomAround(new L.LatLng(mapSettings.defaultPosition[0], mapSettings.defaultPosition[1]), 14)
        setTimeout cb, 2000
      # Unbind after 1st localization
      # mapController.mapInstance.off 'viewreset', mapController.locate

  locateOnViewReset: ->
    mapController.mapInstance.on 'viewreset', mapController.locate

  addPosition: (latlng) ->
    debug "New marker added on "+latlng
    # Delete old markers
    mapController.markerCluster.clearLayers()
    # Add new marker
    if mapController.currentMarker?
      mapController.mapInstance.removeLayer mapController.currentMarker
    mapController.currentMarker = new L.marker new L.LatLng(latlng.lat, latlng.lng),
      draggable:true
    .addTo( mapController.mapInstance)
    # Show popup
    mapController.showMarkerAddPopup mapController.currentMarker
    # Marker moved
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

    # Editing mode
    if mapController.isEditing()
      layers = mapController.markerCluster.getLayers()
      if layers?
        marker = layers[0]
      if marker?
        mapController.showMarkerEditPopup marker

    $('.leaflet-control-position-picker').show()
    # Bind map click to add marker
    mapController.mapInstance.on 'click', (e) ->
      if mapController.positionPickerActive == false
        return
      mapController.addPosition e.latlng

  generateButtonElement: (icoClass, btnClass, btnText) ->
    btn = document.createElement 'button'
    btn.innerHTML = '<span class="glyphicon '+icoClass+'"></span> '+btnText
    btn.className = 'btn '+btnClass+' btn-xs'
    btn.type = 'button'
    btn

  showMarkerEditPopup:(marker) ->
    btnAdd = mapController.generateButtonElement 'glyphicon-ok', 'btn-success', 'Valider ce point'
    btnRemove = mapController.generateButtonElement 'glyphicon-remove', 'btn-danger', 'Supprimer ce point'
    btnRemove.onclick = ->
      debug "ok1"
      mapController.markerCluster.removeLayer marker
      debug "ok2"
      #mapController.disablePositionPicker 'delete', marker
    btnAdd.onclick = ->
      mapController.disablePositionPicker 'save', marker
    div = document.createElement 'div'
    div.innerHTML = marker._popup._content+'<br>'
    div.appendChild btnAdd
    marker.bindPopup(div).openPopup()

  showMarkerAddPopup:(marker) ->
    btnAdd = mapController.generateButtonElement 'glyphicon-ok', 'btn-success', 'Valider ce point'
    btnAdd.onclick = ->
      mapController.disablePositionPicker 'save', marker
    marker.bindPopup(btnAdd).openPopup()

  setCentered: ->
    bounds = mapController.markerCluster.getBounds() if mapController.markerCluster?
    if mapController.markerCluster? && bounds._northEast
      mapController.mapInstance.invalidateSize(false)
      mapController.mapInstance.fitBounds bounds,
        padding: [130,130]
    else
      mapController.mapInstance.setZoomAround(new L.LatLng(mapSettings.defaultPosition[0], mapSettings.defaultPosition[1]), 14)
      mapController.mapInstance.invalidateSize(false)

  disablePositionPicker: (action, selectedMarker) ->
    mapController.positionPickerActive = false
    # Populate GPS field
    if action == 'save'
      gps = selectedMarker.getLatLng()
      $('#article_location').val gps.lat+', '+gps.lng
      selectedMarker.closePopup()
    else if action == 'delete'
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
      $('html,body').animate({ scrollTop: $('#article-container').offset().top }, 'slow')

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
        zoomControl: !Modernizr.touch
        maxZoom: 19
        minZoom: 13

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
        textCancel:'Fermer',
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
      $('.leaflet-control-position-picker.buttons').append('<button type="button" class="btn btn-default btn-xs cancel"><span class="glyphicon glyphicon-remove"></span> Fermer</button></div>')
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
          control= L.DomUtil.create 'div', ''
          control.innerHTML = '<span class="glyphicon glyphicon-minus"></span>'
          control.onclick = ->
            # On mobile, hide the map
            if Modernizr.touch
              $('.map-mobile-toggle').click()
            # On desktop, toggle height
            else
              mapController.heightToggle
          control.className = 'heightToggle leaflet-bar'
          control

      map.addControl(new heightControl())

    # Refresh markers
    @refresh()

  # Refresh markers (delete all & reload)
  refresh: ->
    mapController.deleteMarkers()
    mapController.loadMarkers()

  # Load all markers contained into the current page
  loadMarkers: ->
    debug "Loading markers from the current page"
    markersLoaded = {}
    markers = $('.location[data-latlng!=""], #theme-articles .media-heading[data-latlng!=""]').filter ->
      # Remove duplicates element
      txt = $(this).data('title')
      if (markersLoaded[txt])
        false
      else
        markersLoaded[txt] = true
        true
    debug markers.length + " markers found"
    markers.each ->
      dataLocation = $(this).data("latlng")
      if dataLocation
        latlng = dataLocation.split ', '
        mapController.addMarker
          latitude: latlng[0]
          longitude: latlng[1]
          text: $(this).data "title"
          uri: $(this).data "uri"

  # Erase all markers
  deleteMarkers: ->
    debug 'Map:: Deleting all markers'
    @markerCluster.clearLayers();

  isEditing: ->
    $('.edit_article').length > 0

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
    mapController.markerCluster.addLayer(L.marker([data.latitude, data.longitude],
      draggable:mapController.isEditing()
    ).bindPopup(text))
    mapController.mapInstance.fitBounds mapController.markerCluster.getBounds(),
      padding: [70,70]

  heightToggle: ->
    currentHeight = $('#'+mapSettings.el).height()
    targetHeight = if currentHeight!= mapSettings.originalHeight then mapSettings.originalHeight else mapSettings.originalHeight * 0.3
    $('#'+mapSettings.el).animate
      'height':targetHeight+'px'
    ,500
    $('#'+mapSettings.el).find('.heightToggle span.glyphicon').toggleClass('glyphicon-minus').toggleClass('glyphicon-plus')

  mobileToggle: ->
      # Full height display on mobile
      fullHeight = $(window).height()
      $('#'+mapSettings.el).animate
        'height':fullHeight+'px'
      ,500, ->
          mapController.setCentered()


$(document).ready -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition

# Bind "map:addMarkers"
$(document).on 'map:addMarkers', mapController.addMarkersHandler
$(document).on 'map:addMarker', mapController.addMarkerHandler
$(document).on 'map:refresh', mapController.refresh
