@AjaxLoader =
  load: (dataComponent, toComponent) ->
    targetPath = dataComponent.data 'load'
    if not targetPath
      console.log 'Cannot load content asynchronously for component: ' + dataComponent.attr 'id'
      return false

    if not dataComponent.hasClass 'loaded'
      toComponent.load targetPath
      dataComponent.addClass 'loaded'

    return true
