window['home#index'] = (data) ->
	###if !Modernizr.touch
	  	mapController.locate()
	  else
	  	mapController.locateOnViewReset()###