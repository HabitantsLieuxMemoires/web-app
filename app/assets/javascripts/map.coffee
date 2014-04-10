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
    debug "Map:: Initialization..."
    mapController.mapInstance = new L.Map(el);
    tileLayer = new L.TileLayer(providerSettings.url, {attribution: providerSettings.attrib});
    mapController.mapInstance.setView(new L.LatLng(defaultPosition[0],defaultPosition[1]),13);
    mapController.mapInstance.addLayer(tileLayer);
    @layerGroup = new L.layerGroup();
    L.control.layers null,
      "HLM Markers": mapController.layerGroup
    .addTo(mapController.mapInstance)

  # Erase all markers
  deleteMarkers: ->
    debug 'Map:: Deleting all markers'
    mapController.layerGroup?.clearLayers?;

  # Data updated
  updateData: (e, dataArr) ->
    debug 'Map:: New data'
    #mapController.deleteMarkers()
    if dataArr? and dataArr.length > 0
      for data in dataArr
        debug data
        L.marker([data.latitude, data.longitude]).bindPopup('Dummy text').addTo(mapController.layerGroup)

# Page (re)loaded ?
$(document).ready -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition
$(document).on 'page:load', -> mapController.init mapSettings.osmProviders.osm, mapSettings.el, mapSettings.defaultPosition

# Map data updated
$(document).on 'map:data', mapController.updateData