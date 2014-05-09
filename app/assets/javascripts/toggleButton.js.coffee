window.ButtonToggle =
  Hide: (targetElement)->
      $(targetElement).addClass 'hidden-xs hidden-sm'
      $('.mobile-toggle-button[data-target="'+targetElement+'"]').removeClass 'mobile-toggle-button-active'

  init: ->
    $('.mobile-toggle-button').click (e)->
      targetElement = $(this).data 'target'
      elt = $(this)
      if $(this).hasClass 'mobile-toggle-button-active'
        $(targetElement).show().slideUp 500, -> 
          $(targetElement).addClass 'hidden-xs hidden-sm'
          elt.removeClass 'mobile-toggle-button-active'
      else
        callback = $(this).data 'callback'
        $(targetElement).hide().removeClass('hidden-xs hidden-sm').slideDown 500, ->
          if callback?
            parts = callback.split '.'
            method = window
            $(parts).each ->
              method = method[@]
            method()
          elt.addClass 'mobile-toggle-button-active'


$(document).ready ->
  ButtonToggle.init()