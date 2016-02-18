Wellspring.Behaviors.Dropzone = {
  initialize: function() {
    $(document).on('pageUpdated', this.setupDropzone.bind(this));
  },

  setupDropzone: function(e, data) {
    var dropzone = new Dropzone('img[src=""]', {
      maxFilesize: 256,
      addRemoveLinks: false,
      url: Wellspring.imageUploadPath
    });

    dropzone.on("success", function(file) {
      console.log(file);
      var imageUrl = file.xhr.response;
      $('#entry_body').val($('#entry_body').val() + imageUrl);
    });
  }
}

Wellspring.Behaviors.Dropzone.initialize();
