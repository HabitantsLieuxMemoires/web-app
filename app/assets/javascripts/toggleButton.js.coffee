window.ButtonToggle =
  init: ->
    $('.mobile-toggle-button').click ->
      targetElement = $(this).data 'target'
      if $(this).hasClass 'mobile-toggle-button-active'
        $(targetElement).addClass 'hidden-xs hidden-sm'
        $(this).removeClass 'mobile-toggle-button-active'
      else
        $(targetElement).removeClass 'hidden-xs hidden-sm'
        $(this).addClass 'mobile-toggle-button-active'

        callback = $(this).data 'callback'
        if callback?
          parts = callback.split '.'
          method = window
          $(parts).each ->
            method = method[@]
          method()


$(document).ready ->
  ButtonToggle.init()