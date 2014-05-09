#= require typeahead
#= require selectize

# Will be executed on search article page only
window['search#index'] = (data) ->
  checkboxes = $("#search-page input[type='checkbox']")

  markCheckboxes = (value) ->
    checkboxes.prop("checked", value)

  # Checkboxes are selected by default
  markCheckboxes(true)

  # Selectize tags
  $('#tags').selectize
        plugins: ['remove_button']
        persist: false
        create: (input) ->
          return {
            value: input,
            text: input
          }

  # Binding events
  $('.themes-all').on 'click', (e) ->
    markCheckboxes(true)
    e.preventDefault()

  $('.themes-none').on 'click', (e) ->
    markCheckboxes(false)
    e.preventDefault()


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
        .removeClass('hidden')

    $('#sidebar-actions')
      .css('z-index', 10)
      .animate({
        width: '+=220px',
        duration: 1000
      }, showExtendedSearch)
