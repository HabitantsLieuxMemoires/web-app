wysiImageHelpers = {
  getImageTemplate: function() {
    /* this is what goes in the wysiwyg content after the image has been chosen */
    var tmpl;
    var imgEntry = "<img src='<%= url %>' alt='<%= caption %>' >";
    tmpl = _.template("<div class='wysiwyg-image'>" +
                      imgEntry +
                      "</div>");
    return tmpl;
  }
};

bootWysiImageOverrides = {
  initInsertImage: function(toolbar) {
    var self = this;
    var selectImageModal = $('#modal-select-image');
    var selectImageData = $('#data-select-image');
    var helpers = wysiImageHelpers;

    var insertImage = function(imageData) {
      if(imageData.url) {
        var doc = self.editor.composer.doc;
        var tmpl = helpers.getImageTemplate();
        var chunk = tmpl(imageData);
        self.editor.focus();
        self.editor.composer.commands.exec("insertHTML", chunk);
      }
    };

    selectImageModal.on('loaded.bs.modal', function() {
      var chooser = selectImageModal.find('#image_chooser');
      chooser.on('click', '.thumbnail .btn-primary', function(e) {
        var $row = $(e.currentTarget).parents('.thumbnail');
        // var $row = $(e.delegateTarget).find('.thumbnail');

        insertImage({
          url: $(this).data('url'),
          caption: $row.data('caption')
        })
        selectImageModal.modal('hide');
      });
    });

    selectImageModal.on('hidden.bs.modal', function() {
      self.editor.currentView.element.focus();
    });

    // Handling insert image button click
    toolbar.find('a[data-wysihtml5-command=insertImage]').click(function() {
      var activeButton = $(this).hasClass("wysihtml5-command-active");

      if (!activeButton) {
        var targetUrl = selectImageData.data('load');

        // Showing modal
        selectImageModal.modal({show:true, remote:targetUrl});
        return false;
      } else {
        return true;
      }
    });
  }
};

$.extend($.fn.wysihtml5.Constructor.prototype, bootWysiImageOverrides);
