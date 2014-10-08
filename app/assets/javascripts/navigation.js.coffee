$(document).ready ->
  $('input').placeholder();

  $('.nav-row .nav-col a').on 'click', ->
    $(this).parent().parent().find('.active').removeClass('active')
    $(this).parent().addClass('active')

  # Over effect for article creation button
  $('.article-creation-button>img').on 'mouseover', ->
  	$('.article-creation-button>a').addClass 'active'
  $('.article-creation-button>img').on 'mouseout', ->
  	$('.article-creation-button>a').removeClass 'active'

  ### Image slideshow
  $('.slideshow').simplyScroll 
  	pauseOnHover: false
  	pauseOnTouch: false###