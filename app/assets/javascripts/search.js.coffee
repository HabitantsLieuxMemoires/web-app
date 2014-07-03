#= require shared/typeahead-loader
#= require selectize

# Will be executed on search articles page only
SearchController=
  init:(data) ->
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

window['articles#search'] = (data) ->
  SearchController.init(data);

window['search#index'] = (data) ->
  SearchController.init(data)


# Will be executed on every pages (excepting admin ones)

$(document).ready ->
  typeahead     = $('#search-article')

  # Redirect on show article page when clicked (data.id contains article' slug)
  redirectOnClick = (data) ->
    window.location.href = "/articles/" + encodeURIComponent(data.id)

  Typeahead.init(typeahead, 'search', redirectOnClick)

  # Extend size of search input container when appended button clicked
  $('#bt-search').on 'click', ->
    $(".searchbox form").submit()

  # Redirect to extended search when enter pressed on search field
  $('#search-article').on 'keypress', (e) ->
    if (e.which == 13)
      $(".searchbox form").submit()

  # On mobile, when search input focuses, scroll to !
  if Modernizr.touch
    $('#search-article').on 'focus', ->
      $('html, body').animate({
        scrollTop: $('#search-article').offset().top
    }, 500);
