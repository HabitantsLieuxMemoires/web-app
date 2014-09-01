window['home#index'] = (data) ->
	mapController.removeDuplicates = true
	###if !Modernizr.touch
	  	mapController.locate()
	  else
	  	mapController.locateOnViewReset()###