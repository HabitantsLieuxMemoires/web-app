#= require typeahead

@Typeahead =
  init: (@component, name, callback = null, minLength = 2) ->
    articlesRemote = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: '/articles/autocomplete?query=%QUERY'
    })

    articlesRemote.initialize()

    redirect = @component.data('redirect')

    typeahead = @component.typeahead({
      minLength: minLength,
      highlight: true
    }, {
      name: name,
      displayKey: 'title',
      source: articlesRemote.ttAdapter()
    })

    typeahead.on 'typeahead:selected', (e, data, suggestion) ->
      if redirect
        window.location.href = "/articles/" + encodeURIComponent(data.id)
      else if callback
        callback(data)

    return typeahead
