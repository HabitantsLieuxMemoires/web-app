#= require selectize
#= require jasny-bootstrap.min
#= require ekko-lightbox.min
#= require bootstrap-wysihtml5/b3
#= require wysihtml5.autoresize
#= require socialite.min
#= require social
#= require waypoints
#= require waypoints-infinite
#= require shared/remote-tabs
#= require shared/ekko-lightbox-loader
#= require shared/modal-form-cleaner
#= require editor/custom-wysihtml5-image
#= require editor/custom-wysihtml5-link
#= require editor/custom-wysihtml5-templates

window['articles#new'] = (data) ->
  UI.initEditor($('#article_body'))
  UI.initTagsSelector($('#article_tags'))

window['articles#edit'] = (data) ->
  UI.initTabs()
  UI.initEditor($('#article_body'))
  UI.initTagsSelector($('#article_tags'))

window['articles#show'] = (data) ->
  UI.initTabs()
  UI.infineComments()

UI =
  initEditor: (@editor) ->
    editor = @editor.wysihtml5('deepExtend', {
        customTemplates: wysiwygTemplates,
        parserRules: {
          classes: {
            "wysiwyg-image": 1
          },
          tags: {
            "div": 1
          }
        }
    })

  initTagsSelector: (@component, @delimiter = ',') ->
    @component.selectize
        plugins: ['remove_button']
        delimiter: @delimiter
        persist: false
        create: (input) ->
          return {
            value: input,
            text: input
          }

  initTabs: ->
    callback = ->
      $.waypoints('refresh')

    $('[data-toggle=tab]').on 'show.bs.tab', (e) ->
      RemoteTabs.triggerTabChanged(e, callback)

  infineComments: ->
    debug 'Initializing infinite comments...'
    $('#comments-list').waypoint 'infinite',
      more: '.more-comments-link'
      items: '.comment'
      loadingClass: 'comments-loader'
