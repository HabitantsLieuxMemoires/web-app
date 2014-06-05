window['admin/users#index'] = (data) ->
  $('.bt-change-role').on 'click', (e) ->
    e.preventDefault

    # Loading associated user id
    user = $(this).data('user')

    # Launching modal
