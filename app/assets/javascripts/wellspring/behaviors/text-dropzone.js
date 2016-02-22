Wellspring.Behaviors.TextDropzone = {
  selectors: {
    textarea: '[data-behavior~=text-dropzone]',
    form: 'form#edit_entry'
  },

  initialize: function() {
    $(document).bind('ready', this.setupDropzone.bind(this));
  },

  setupDropzone: function(e, data) {
    var $textarea = $(this.selectors.textarea);

    if ($textarea.length == 0) {
      return;
    }

    var dropzone = new Dropzone(this.selectors.textarea, {
      maxFilesize: 256,
      addRemoveLinks: false,
      clickable: false,
      url: Wellspring.imageUploadPath + '?entry_id=' + $(this.selectors.form).attr('data-entry-id')
    });

    dropzone.on("success", function(file) {
      var imageUrl = file.xhr.response;
      $textarea.insertAtCursor('![](' + imageUrl + ')');
      $textarea.keyup();
    });
  }
}

Wellspring.Behaviors.TextDropzone.initialize();
