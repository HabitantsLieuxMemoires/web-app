@RemoteTabs =
  triggerTabChanged: (e, callback) ->
    obj = $(e.target)
    url = obj.data('tab-url')
    div = $( '#' + obj.attr('href').split('#')[1]);

    if url
      if not obj.hasClass('loaded') and not obj.hasClass('loading')
        this.executeRemoteCall(url, obj, div, callback)

  executeRemoteCall: (url, obj, div, callback) ->
    $.ajax({
      url: url,
      success: (data) ->
        obj.removeClass('loading')

        if data
          if not obj.hasClass('loaded')
            obj.addClass('loaded')

          div.append(data)

          if callback
            callback()
    })
