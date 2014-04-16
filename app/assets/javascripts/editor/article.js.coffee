@ArticleEditor =

  init: (@selector) ->
    console.log "Initializing editor "
    tinyMCE.init
      selector: @selector
      toolbar1: "bold underline italic strikethrough | removeformat | btnTitre btnChapeau btnSection"
      menubar: false
      statusbar: false
      content_css:"/assets/tinymce_preview.css" #TODO: Warning -> DO NOT WORK in PRODUCTION
      plugins: "code"
      height: 400
      style_formats: [
        {title: 'Titre', block: 'h1'}
        {title: 'Chapeau', block: 'p'}
        {title: 'Section', block: 'section', wrapper: true, merge_siblings: false}
      ]
      visualblocks_default_state: true,
      end_container_on_empty_block: true
      setup: (editor) ->
        ArticleEditor.setupLayout editor

      # Fix buttons alignment
      # $('.mce-toolbar .mce-last:last').parents('.mce-container:nth(0)').css('float','right');

  setupLayout: (editor) ->
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
