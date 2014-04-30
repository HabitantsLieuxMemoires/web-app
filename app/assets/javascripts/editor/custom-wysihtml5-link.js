bootWysiLinkOverrides = {
  initInsertLink: function(toolbar) {
    var self = this;
    var insertLinkModal = $('#modal-insert-link');
    var urlInput = insertLinkModal.find('.insert-link-url');

    var insertLink = function(linkData) {
      if(linkData) {
        self.editor.currentView.element.focus();
        self.editor.composer.commands.exec("createLink", {
            'href' : linkData.full_url,
            'target' : '_self',
            'rel' : ''
        });

        insertLinkModal.modal('hide');
      }
    };

    // Initializing typeahead (to be refactored)
    var articlesRemote = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: '/articles/autocomplete?query=%QUERY'
    });
    articlesRemote.initialize();

    var typeahead = urlInput.typeahead({
      minLength: 2,
      highlight: true
    }, {
      name: 'article-links',
      displayKey: 'title',
      source: articlesRemote.ttAdapter()
    })

    typeahead.on('typeahead:selected', function(e, data, suggestion) {
      insertLink(data);
    });

    insertLinkModal.on('hidden.bs.modal', function() {
      urlInput.val('');
      self.editor.currentView.element.focus();
    });

    // Handling insert link button click
    toolbar.find('a[data-wysihtml5-command=createLink]').click(function(e) {
      var activeButton = $(this).hasClass("wysihtml5-command-active");

      if (!activeButton) {
        self.editor.currentView.element.focus(false);
        insertLinkModal.modal({show:true});
        return false;
      } else {
        return true;
      }
    });
  }
};

$.extend($.fn.wysihtml5.Constructor.prototype, bootWysiLinkOverrides);
