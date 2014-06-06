window['admin/users#index'] = (data) ->
  $('.bt-change-role').on 'click', (e) ->
    e.preventDefault

    # Loading associated user id
    user = $(this).data('user')

    # Updating modal field
    $('#modal-change-role').find('#_user_id').val(user)

