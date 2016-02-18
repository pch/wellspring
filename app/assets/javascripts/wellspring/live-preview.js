
var Wellspring = Wellspring || {};

Wellspring.Utils = {
  // Source: https://remysharp.com/2010/07/21/throttling-function-calls
  debounce: function(fn, delay) {
    var timer = null;
    return function () {
      var context = this, args = arguments;
      clearTimeout(timer);
      timer = setTimeout(function () {
        fn.apply(context, args);
      }, delay);
    };
  }
};

Wellspring.LivePreview = {
  selectors: {
    textarea: 'form textarea',
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

Wellspring.LivePreview.initialize();
