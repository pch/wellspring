Wellspring.Behaviors.Alert = {
  closeBtnClass: '.alert-close',

  initialize: function() {
    $(this.closeBtnClass).bind('click', (function(_this) {
      return function(event) {
        $(event.target).parent().hide();
        return event.preventDefault();
      };
    })(this));

    return setTimeout((function(_this) {
      return function() {
        return $(".flash").fadeOut(1000);
      };
    })(this), 3000);
  }
}

Wellspring.Behaviors.Alert.initialize();
