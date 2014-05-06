#= require shared/typeahead-loader

window['admin/features#index'] = (data) ->
  typeahead     = $('.select-article-url')
  featureData   = $('#feature-data')
  url           = null

  # Initializing typeahead
  typeaheadCallback = (data) ->
    url = '/admin/features/' + featureData.data('id') + '/articles/' + data.id + '/feature'

  Typeahead.init(typeahead, 'articles', typeaheadCallback)

  # Binding events
  $('#add-article').on 'click', ->
    if url
      $.ajax
        type: 'GET',
        url: url
        dataType: 'script'


