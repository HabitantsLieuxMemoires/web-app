window.debug= (txt) ->
  environment = $('body').data('env')
  if environment != "production" and console? and console.log? and txt?
    console.log txt
