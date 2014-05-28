#= require shared/typeahead-loader

window['admin/features#edit'] = (data) ->
  typeahead     = $('.select-article-url')
  featureData   = $('#feature-data')
  url           = null

  # Initializing typeahead
  typeaheadCallback = (data) ->
    url = '/admin/articles/' + data.id + '/feature'

  Typeahead.init(typeahead, 'articles', typeaheadCallback)

  # Binding events
  $('#add-article').on 'click', ->
    if url
      $.ajax
        type: 'GET',
        url: url
        dataType: 'script'


