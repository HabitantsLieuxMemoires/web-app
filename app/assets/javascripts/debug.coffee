window.debug= (txt) ->
    if ENV != "production" and console? and console.log? and txt?
      console.log txt