$ ->
  $('#article_tags').selectize
    plugins: ['remove_button']
    delimiter: ','
    persist: false
    create: (input) ->
      return {
        value: input,
        text: input
      }
