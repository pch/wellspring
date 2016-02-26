Wellspring.Behaviors.Dropdown = {
  initialize: function() {
    $(document).ready(function() {
      $('[data-behavior~=dropdown] .nav-item').click(function(e) {
        $(this).siblings("ul").toggleClass("visible");
        e.preventDefault();
      });
    });

    $(window).click(function(event) {
      if (!$('[data-behavior~=dropdown]').has(event.target).length) {
        $('[data-behavior~=dropdown] ul').removeClass("visible");
      }
    });
  }
}

Wellspring.Behaviors.Dropdown.initialize();