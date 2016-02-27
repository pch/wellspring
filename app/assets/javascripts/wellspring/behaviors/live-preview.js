// Source: https://richonrails.com/articles/text-area-manipulation-with-jquery
jQuery.fn.extend({
  insertAtCursor: function(myValue) {
    return this.each(function(i) {
      if (document.selection) {
        //For browsers like Internet Explorer
        this.focus();
        sel = document.selection.createRange();
        sel.text = myValue;
        this.focus();
      }
      else if (this.selectionStart || this.selectionStart == '0') {
        //For browsers like Firefox and Webkit based
        var startPos = this.selectionStart;
        var endPos = this.selectionEnd;
        var scrollTop = this.scrollTop;
        this.value = this.value.substring(0, startPos) + myValue +
                            this.value.substring(endPos,this.value.length);
        this.focus();
        this.selectionStart = startPos + myValue.length;
        this.selectionEnd = startPos + myValue.length;
        this.scrollTop = scrollTop;
      } else {
        this.value += myValue;
        this.focus();
      }
    })
  }
});

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
