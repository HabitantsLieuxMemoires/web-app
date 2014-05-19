$(document).ready ->
	# Ajax Loader
	$('.navbar').ajaxSpin
  		spinjsOpts:
  			shadow: true
  			color: '#C0C0C0'

  	# Modal Form loader
  	$('[data-toggle="modal"]').each ->
  		target = $($(@).data('target'))
  		# Modal Loaded
  		target.on 'loaded.bs.modal', ->
  			debug "Modal loaded"
  			debug target.find('.modal-footer').prepend '<img class="loader" src="/assets/ajax-loader.gif">'
  			# Submit
  			target.find('form').on 'submit', ->
  				target.find('.loader').show()
  				# Disable submit button
  				target.find('[type=submit]').prop 'disabled', true
  		# Modal Hide
  		target.on 'hidden.bs.modal', ->
  			debug "Modal hidden"
  			target.find('.loader').remove()
  		# Modal Open
  		target.on 'show.bs.modal', ->
  			# Enable submit button
  			target.find('[type=submit]').prop 'disabled', false