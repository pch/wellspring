Wellspring.Behaviors.Hero = {
  initialize: function() {
    $(document).ready(this.setupDropzone.bind(this));
  },

  setupDropzone: function(e, data) {
    var dropzone = new Dropzone('[data-behavior~=hero]', {
      maxFilesize: 256,
      addRemoveLinks: false,
      url: Wellspring.imageUploadPath + '?entry_id=' + $('form#edit_entry').attr('data-entry-id') + '&hero=true'
    });

    dropzone.on("success", function(file) {
      console.log(file);
      console.log(this);
      // this.removeFile(file);
      var imageUrl = file.xhr.response;
    });
  }
}

Wellspring.Behaviors.Hero.initialize();