$(document).ready(function() {
  $topbar = $('.topbar');
  $sidebar = $('.sidebar');
  $mainWrapper = $('.main-wrapper');
  $mainContent = $('.main-content');

  // Topbar behavior
  $(document).on('scroll', function() {
    let bannerHeight = $('.banner').css('height');
    bannerHeight = bannerHeight.slice(0, bannerHeight.length - 2);
    if (window.scrollY > bannerHeight) {
      $topbar.css('position', 'fixed');
      $sidebar.css('position', 'fixed');
      $sidebar.css('top', '50px');
      $mainWrapper.css('padding-top', '100px');
    } else {
      $topbar.css('position', 'relative');
      $sidebar.css('position', 'absolute');
      $sidebar.css('top', 'auto');
      $mainWrapper.css('padding-top', '50px');
    }
  });

  // Toggle sidebar
  $toggleBtn = $('.toggle-sidebar');
  $bar = $toggleBtn.find('.bar');

  $toggleBtn.click(function() {
    if (!$toggleBtn.hasClass('clicked')) {
      $toggleBtn.addClass('clicked');
      $toggleBtn.css('background', 'white');
      $bar.css('background', 'black');
      $bar.eq(1).css('margin', '6px 0');

      $sidebar.animate({ left: '0' }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: '175px' }, { duration: 300, queue: false });
    } else {
      $sidebar.animate({ left: '-175px' }, { duration: 300, queue: false, done: function() {
        $toggleBtn.removeClass('clicked');
        $toggleBtn.removeAttr('style');
        $bar.removeAttr('style');
      } });

      $mainContent.animate({ marginLeft: '0' }, { duration: 300, queue: false , done: function() {
        $(this).removeAttr('style');
      } });
    }
  });
});
