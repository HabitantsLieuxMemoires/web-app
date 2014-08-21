#= require bootstrap/bootstrap-validator

# Modal form cleaner
jQuery ->
  $('.modal').each ->
    $(this).on 'hidden.bs.modal', ->
      form = $(this).find('form')[0]
      if form
        # Resetting validator
        validator = $(form).data('bootstrapValidator')
        if validator
          validator.resetForm(false)

        # Resetting form
        $(form).find('input:text, input:password, textarea').val('')
        $(form).find('input:radio, input:checkbox').removeAttr('checked').removeAttr('selected')
