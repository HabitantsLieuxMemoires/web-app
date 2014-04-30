#= require typeahead

window.Search =
  init: ->
    debug 'Initializing typeahead'
    articlesRemote = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: '/articles/autocomplete?query=%QUERY'
    })

    articlesRemote.initialize()

    elements = $('.typeahead')
    elements.each (index, element) =>
      redirect = $(element).data('redirect')

      typeahead = $(element).typeahead({
        minLength: 2,
        highlight: true
      }, {
        name: 'articles',
        displayKey: 'title',
        source: articlesRemote.ttAdapter()
      })

      if redirect
        typeahead.on 'typeahead:selected', (e, data, suggestion) ->
          window.location.href = "/articles/" + encodeURIComponent(data.id)

$(document).ready ->
  Search.init()
$(document).on 'page:load', ->
  Search.init()

