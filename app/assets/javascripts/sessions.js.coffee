#= require bootstrap/bootstrap-validator

window['sessions#new'] = (data) ->
  # Enable js validation
  $('form').bootstrapValidator
    live: 'enabled'
    feedbackIcons:
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    fields:
      identity:
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          stringLength:
            min: 4
            message: I18n.t("errors.messages.too_short.other", {count: "4"})
      password:
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          stringLength:
            min: 8
            message: I18n.t("errors.messages.too_short.other", {count: "8"})



