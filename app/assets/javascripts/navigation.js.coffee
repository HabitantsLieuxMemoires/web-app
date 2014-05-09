$(document).ready ->
  $('.nav-row .nav-col a').on 'click', ->
    $(this).parent().parent().find('.active').removeClass('active')
    $(this).parent().addClass('active')
