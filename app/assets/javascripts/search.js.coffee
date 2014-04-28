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

    typeahead = $('.typeahead').typeahead({
      minLength: 2,
      highlight: true
    }, {
      name: 'articles',
      displayKey: 'title',
      source: articlesRemote.ttAdapter()
    })

    typeahead.on 'typeahead:selected', (e, data, suggestion) ->
      window.location.href = "/articles/" + encodeURIComponent(data.id)

$(document).ready ->
  Search.init()
$(document).on 'page:load', ->
  Search.init()

