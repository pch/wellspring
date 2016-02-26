Wellspring.Behaviors.Hero = {
  previewTemplate: '<div class="dz-preview dz-file-preview">' +
                   '  <div class="dz-details">' +
                   '    <img data-dz-thumbnail />' +
                   '  </div>' +
                   '  <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress></span></div>' +
                   '  <div class="dz-success-mark"></div>' +
                   '  <div class="dz-error-mark">Failed</div>' +
                   '</div>',

  initialize: function() {
    $(document).ready(this.setupDropzone.bind(this));
  },

  setupDropzone: function(e, data) {
    var $dropzone = $('[data-behavior~=hero]');
    if ($dropzone.length == 0) {
      return;
    }

    var dropzone = new Dropzone('[data-behavior~=hero]', {
      maxFilesize: 256,
      addRemoveLinks: false,
      uploadMultiple: false,
      thumbnailWidth: null,
      thumbnailHeight: null,
      previewTemplate: this.previewTemplate,
      url: Wellspring.imageUploadPath + '?entry_id=' + $('form#edit_entry').attr('data-entry-id') + '&hero=true'
    });

    dropzone.on("success", function(file) {
      var imageUrl = file.xhr.response;
    });

    dropzone.on("removedfile", function(file) {
      console.log(file);
    });
  }
}

Wellspring.Behaviors.Hero.initialize();