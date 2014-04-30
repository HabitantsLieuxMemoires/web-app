jQuery ->
  $('.modal').each ->
    $(this).on 'hidden.bs.modal', ->
      form = $(this).find('form')[0]
      if form
        form.reset()
