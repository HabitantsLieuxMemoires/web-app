jQuery ->
  $('.modal').each ->
    $(this).on 'hidden.bs.modal', ->
      form = $(this).find('form')[0]
      if form
        # Resetting form
        $(form).find('input:text, input:password, input:file, select, textarea').val('')
        $(form).find('input:radio, input:checkbox').removeAttr('checked').removeAttr('selected')

        # Resetting file input
        $(form).find('.fileinput').fileinput('clear')

        # Resetting validator
        validator = $(form).data('bootstrapValidator')
        if validator
          validator.resetForm()
