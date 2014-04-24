jQuery ->
  $('.modal').each ->
    $(this).on 'hidden.bs.modal', ->
      $(this).find('form')[0].reset()
