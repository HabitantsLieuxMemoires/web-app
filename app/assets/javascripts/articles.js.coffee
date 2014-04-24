#= require selectize
#= require jasny-bootstrap.min
#= require ekko-lightbox.min
#= require jquery.scrollTo.min
#= require bootstrap-wysihtml5/b3
#= require wysihtml5.autoresize
#= require shared/ajax-loader
#= require shared/ekko-lightbox-loader
#= require shared/modal-form-cleaner
#= require editor/custom-wysihtml5-options
#= require editor/custom-wysihtml5-image

window['articles#new'] = (data) ->
  UI.initEditor($('#article_body'))
  UI.initTagsSelector($('#article_tags'))

window['articles#edit'] = (data) ->
  UI.initEditor($('#article_body'))
  UI.initTagsSelector($('#article_tags'))

  $('#show_comments').on 'click', ->
    Data.loadComments()

  $('#show_images').on 'click', ->
    Data.loadImages()

window['articles#show'] = (data) ->
  $('#show_comments').on 'click', ->
    Data.loadComments()

  $('#show_images').on 'click', ->
    Data.loadImages()

UI =
  initEditor: (editor) ->
    editor = editor.wysihtml5(
      $.extend(wysiwygOptions,
        {
          link: false,
          html:false,
          color:false,
          "events": {
            "load": ->
              $('iframe.wysihtml5-sandbox').wysihtml5_size_matters();
          }
        }
      )
    )

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

Data =
  loadComments: ->
    articleComments  = $('#article-comments')
    commentsList     = $('#comments-list')

    if articleComments.is ':visible'
      Helpers.toggleArticleContent articleComments, true
    else if AjaxLoader.load(articleComments, commentsList)
      # Displaying comments
      Helpers.toggleArticleContent articleComments, false

      # Then scrolling to them
      $('html, body').scrollTo articleComments

  loadImages: ->
    articleImages  = $('#article-images')
    imagesList = $('#images-list')

    if articleImages.is ':visible'
      Helpers.toggleArticleContent articleImages, true, true
    else if AjaxLoader.load(articleImages, imagesList)
      # Displaying images
      Helpers.toggleArticleContent articleImages, false, true

Helpers =
  toggleArticleContent: (withContent, show, replace = false) ->
    articleContent = $('#article-content')

    if show
      withContent.addClass 'hidden'
      if replace
        articleContent.removeClass 'hidden'
    else
      withContent.removeClass 'hidden'
      if replace
        articleContent.addClass 'hidden'
