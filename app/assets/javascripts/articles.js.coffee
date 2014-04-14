editorController =
  setButtons: (editor) ->
    debug "Initializaing editor's buttons"
    # Titre
    editor.addButton 'btnTitre',
      text: 'Titre',
      icon: false,
      onclick: ->
        editor.execCommand('mceToggleFormat', false, "h1");
      onPostRender: ->
        self = @
        setup = ->
          editor.formatter.formatChanged "h1", (state) ->
            self.active state
        if editor.formatter then setup() else editor.on 'init', setup
    # Chapeau
    editor.addButton 'btnChapeau',
      text: 'Chapeau',
      icon: false,
      onclick: ->
        editor.selection.setContent '<p class="chapeau">' + editor.selection.getContent() + '</p>'
    # Chapeau
    editor.addButton 'btnSection',
      class:'test',
      text: 'Section',
      icon: false,
      onclick: ->
        editor.selection.setContent '<section>' + editor.selection.getContent() + '</section>'

  # TinyMCE Initilization
  init: ->
    debug "Initializing editor "
    tinyMCE.init
      selector: 'textarea.tinymce'
      toolbar1: "bold underline italic strikethrough | removeformat | btnTitre btnChapeau btnSection"
      menubar: false
      statusbar: false
      content_css:"/assets/tinymce_preview.css"
      plugins: "code"
      style_formats: [
        {title: 'Titre', block: 'h1'}
        {title: 'Chapeau', block: 'p'}
        {title: 'Section', block: 'section', wrapper: true, merge_siblings: false}
      ]
      visualblocks_default_state: true,
      end_container_on_empty_block: true
      setup: (editor) ->
        editorController.setButtons editor

      # Fix buttons alignment
      # $('.mce-toolbar .mce-last:last').parents('.mce-container:nth(0)').css('float','right');

ready = ->
  $('#article_tags').selectize
    plugins: ['remove_button']
    delimiter: ','
    persist: false
    create: (input) ->
      return {
        value: input,
        text: input
      }

  toggleArticleContent = (withContent, show, replace = false) ->
    articleContent = $('#article-content')

    if show
      withContent.addClass 'hidden'
      if replace
        articleContent.removeClass 'hidden'
    else
      withContent.removeClass 'hidden'
      if replace
        articleContent.addClass 'hidden'

  $('#show_comments').on 'click', ->
    articleComments  = $('#article-comments')

    if articleComments.is ':visible'
      toggleArticleContent articleComments, true
    else
      # Loading comments
      targetPath = articleComments.data 'load'
      if not targetPath
        console.log 'Cannot load content asynchronously for component: ' + articleImages.attr 'id'
        return false

      if not articleComments.hasClass 'loaded'
        commentsList = $('#comments-list')
        commentsList.load targetPath
        articleComments.addClass 'loaded'

      toggleArticleContent articleComments, false

  $('#show_images').on 'click', ->
    articleImages  = $('#article-images')

    if articleImages.is ':visible'
      toggleArticleContent articleImages, true, true
    else
      # Loading images
      targetPath = articleImages.data 'load'
      if not targetPath
        console.log 'Cannot load content asynchronously for component: ' + articleImages.attr 'id'
        return false

      if not articleImages.hasClass 'loaded'
        imagesList = $('#images-list')
        imagesList.load targetPath
        articleImages.addClass 'loaded'

      toggleArticleContent articleImages, false, true

  editorController.init()

# Page (re)loaded ?
$(document).ready ready
$(document).on 'page:load', ready
