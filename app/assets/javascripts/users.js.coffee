#= require bootstrap/bootstrap-validator

window['users#new'] = (data) ->
  # Enable js validation
  $('.new_user').bootstrapValidator
    live: 'enabled'
    feedbackIcons:
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    fields:
      'user[email]':
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          emailAddress:
            message: I18n.t("errors.messages.invalid_email")
      'user[nickname]':
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          stringLength:
            min: 4
            message: I18n.t("errors.messages.too_short.other", {count: "4"})
      'user[password]':
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          stringLength:
            min: 8
            message: I18n.t("errors.messages.too_short.other", {count: "8"})
          identical:
            field: 'user[password_confirmation]'
            message: I18n.t("errors.messages.confirmation")
      'user[password_confirmation]':
        validators:
          notEmpty:
            message: I18n.t("errors.messages.blank")
          stringLength:
            min: 8
            message: I18n.t("errors.messages.too_short.other", {count: "8"})
          identical:
            field: 'user[password]'
            message: I18n.t("errors.messages.confirmation")



