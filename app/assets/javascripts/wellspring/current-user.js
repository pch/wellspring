var Wellspring = Wellspring || {};

Wellspring.CurrentUser = {
  initialize: function() {
    if (!this.isLoggedIn()) {
      $(function() {
        this.hideMembersOnlyLinks();
      }.bind(this));
    }
  },

  isLoggedIn: function() {
    return Wellspring.userIsLoggedIn || false;
  },

  hideMembersOnlyLinks: function() {
    $('[data-access~=members-only]').each(function() {
      $(this).attr('href', Wellspring.loginPath);
      $(this).attr('data-behavior', 'modal');
    });
  }
}

Wellspring.CurrentUser.initialize();
