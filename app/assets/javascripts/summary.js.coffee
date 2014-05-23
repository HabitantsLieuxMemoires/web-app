Summary = 
	bind: ->
		debug "Summary initialized"
		$('.well-sm a').each ->
			debug "Done : "
			debug $(@).text()
			$(@).on 'click', Summary.linkClicked

	linkClicked:(e) ->
		e.preventDefault()
		targetTitle = $(@).text() # Addslashes
		targetLevel = $(@).data 'level'
		if targetLevel?
			$('html, body').animate
		        scrollTop: $("h"+targetLevel+":contains('"+targetTitle+"')").offset().top

$(document).ready ->
  Summary.bind()