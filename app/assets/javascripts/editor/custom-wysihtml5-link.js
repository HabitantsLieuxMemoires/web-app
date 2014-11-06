bootWysiLinkOverrides = {
  initInsertLink: function(toolbar) {
    var self = this;
    var insertLinkModal = $('#modal-insert-link');
    var urlInput = insertLinkModal.find('.insert-link-url');

    var insertLink = function(linkData) {
      if(linkData) {
        self.editor.currentView.element.focus();
        self.editor.composer.commands.exec("createLink", {
            'href' : linkData.full_url
        });

        insertLinkModal.modal('hide');
      }
    };

    // Initializing typeahead
    Typeahead.init(urlInput, 'search', insertLink);

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
