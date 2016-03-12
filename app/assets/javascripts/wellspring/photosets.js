var Wellspring = Wellspring || {};

// Responsive Photosets
//
// Based heavily on/stolen from: https://medium.com/coding-design/responsive-photosets-7742e6f93d9e
Wellspring.Photosets = {
  initialize: function() {
    $(window).on('resize', Wellspring.Utils.debounce(this.align.bind(this), 100));
    $(window).on('pageUpdated', this.align.bind(this));
    $(document).ready(function() {
      $(window).resize();
    });
  },

  align: function(event) {
    $('.photoset-row').each(function () {
      var $pi    = $(this).find('.photoset-item'),
          cWidth = $(this).parent('.photoset').width();

      var ratios = $pi.map(function () {
        return $(this).find('img').data('ratio');
      }).get();

      var sumRatios = 0, sumMargins = 0,
          minRatio  = Math.min.apply(Math, ratios);

      for (var i = 0; i < $pi.length; i++) {
        sumRatios += ratios[i] / minRatio;
      };

      $pi.each(function() {
        sumMargins += parseInt($(this).css('margin-left')) + parseInt($(this).css('margin-right'));
      });

      $pi.each(function (i) {
        var minWidth = (cWidth - sumMargins) / sumRatios;
        $(this).find('img')
          .width(Math.ceil(minWidth / minRatio) * ratios[i])
          .height(Math.ceil(minWidth / minRatio));
      });
    });
  }
};

Wellspring.Photosets.initialize();
