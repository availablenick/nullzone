$(document).ready(function() {
  $topbar = $('.topbar');
  $sidebar = $('.sidebar');
  $mainWrapper = $('.main-wrapper');
  $mainContent = $('.main-content');

  sidebarState = localStorage.getItem('sidebarState');
  if (sidebarState === 'hidden' || !sidebarState) {
    $sidebar.removeAttr('style');
    $mainContent.removeAttr('style');
  } else {
    $sidebar.css('left', '0');
    $mainContent.css('margin-left', '175px');
  }

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
    sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState === 'hidden' || !sidebarState) {
      localStorage.setItem('sidebarState', 'visible');
      $sidebar.animate({ left: '0' }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: '175px' }, { duration: 300, queue: false });
    } else {
      localStorage.setItem('sidebarState', 'hidden');
      $sidebar.animate({ left: '-175px' }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: '0' }, { duration: 300, queue: false });
    }
  });
});
