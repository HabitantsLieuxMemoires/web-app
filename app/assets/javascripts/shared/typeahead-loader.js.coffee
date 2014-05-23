#= require typeahead

@Typeahead =
  init: (@component, name, onSelected = null, minLength = 2) ->
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
      source: articlesRemote.ttAdapter(),
      templates:
        suggestion: (obj) ->
          html = '<img src="'+obj.random_thumb+'" class="img-rounded">'
          html+= '<span class="author">par '+obj.author+'</span>'
          html+= '<span class="title">'+obj.title+'</span>'
          html+= '<div class="summary">'+obj.summary+'</div>'
          return html
    })

    typeahead.on 'typeahead:selected', (e, data, suggestion) ->
      if redirect
        window.location.href = "/articles/" + encodeURIComponent(data.id)
      else if onSelected
        onSelected(data)

    return typeahead
