Wellspring.Behaviors.LivePreview = {
  selectors: {
    textarea: '[data-behavior~=live-preview]',
    preview:  '#live-preview',
    wordCount: '#word-count'
  },

  initialize: function() {
    $(document).on('keyup', this.selectors.textarea, Wellspring.Utils.debounce(this.generatePreview.bind(this), 200));
    $(document).ready(function() {
      $(this.selectors.textarea).keyup();
    }.bind(this));
  },

  generatePreview: function(event) {
    var preview = $(this.selectors.preview);
    var previewUrl = preview.attr('data-preview-url');
    var wordCount = $(this.selectors.wordCount);

    $.ajax({
      type: 'POST',
      url: previewUrl,
      data: {
        text: event.target.value
      },

      success: function(data) {
        preview.html(data);
        var words = preview.text().match(/(\w+)/g);
        if (words) {
          wordCount.html(words.length);
        }

        $(document).trigger("pageUpdated", {});
      }
    });
  }
};

Wellspring.Behaviors.LivePreview.initialize();
