#= require typeahead

# Will be executed on every pages (excepting admin ones)

$(document).ready ->
  typeahead     = $('#search-article')

  # Redirect on show article page when clicked (data.id contains article' slug)
  redirectOnClick = (data) ->
    window.location.href = "/articles/" + encodeURIComponent(data.id)

  Typeahead.init(typeahead, 'search', redirectOnClick)

  # Extend size of search input container when appended button clicked
  $('#bt-search').on 'click', ->

    showExtendedSearch = (parent) ->
      $('#bt-search-extended')
        .appendTo('.search-container')
        .removeClass('hidden', 500, "easeOutQuint")

    $('#sidebar-actions')
      .css('z-index', 10)
      .animate({
        width: '+=220px',
        duration: 1000
      }, showExtendedSearch)
