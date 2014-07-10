#= require spin.min
#= require ladda.min
#= require ladda.jquery.min

# Modal Spin loader
jQuery ->
  $('.modal').each ->
    if $(this).attr('data-no-spin')
        return

    $(this).on 'loaded.bs.modal', ->
      checkValidationBeforeSubmit = (form, e, loader) ->
        # Cancelling submit if form is not valid
        bootstrapValidator = $(form).data('bootstrapValidator')
        if bootstrapValidator && !bootstrapValidator.isValid()
          e.preventDefault()
          return false

        if loader
          loader.ladda('start')

        return true

      form   = $(this).find('form')
      loader = form.find('.ladda-button').ladda()

      # Handling submit event
      form.on 'submit ajax:before': (e) ->
        # Checking form valid
        return checkValidationBeforeSubmit(this, e, loader)
      form.on 'ajax:complete': (e) ->
        if loader
          loader.ladda('stop')
