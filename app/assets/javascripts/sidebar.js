$(document).ready(function() {
  $sidebarLg = $('.sidebar-main-wrapper > aside');
  $sidebarNotLgWrapper = $('body > .sidebar-wrapper');
  $sidebarNotLg = $sidebarNotLgWrapper.find('aside');
  $mainContent = $('.main-content');

  if ($sidebarLg.css('display') !== 'none') {  
    sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState === 'hidden' || !sidebarState) {
      $sidebarLg.removeAttr('style');
      $mainContent.removeAttr('style');
    } else {
      $sidebarLg.css('left', '0');
      $mainContent.css('margin-left', $sidebarLg.css('width'));
    }
  }

  $sidebarNotLg.click(function(event) {
    event.stopPropagation();
  });

  $sidebarNotLgWrapper.click(function() {
    $sidebarNotLg.animate({ left: '-' + $sidebarNotLg.css('width') }, 300, function() {
      $sidebarNotLgWrapper.hide();
    });
  });

  // Toggle sidebar
  $toggleBtn = $('.toggle-sidebar');
  $toggleBtn.click(function() {
    if ($sidebarLg.css('display') === 'none') {
      $sidebarNotLgWrapper.show();
      $sidebarNotLg.animate({ left: '0' }, 300);
      return;
    }

    sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState === 'hidden' || !sidebarState) {
      localStorage.setItem('sidebarState', 'visible');
      $sidebarLg.animate({ left: '0' }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: $sidebarLg.css('width') }, { duration: 300, queue: false });
    } else {
      localStorage.setItem('sidebarState', 'hidden');
      $sidebarLg.animate({ left: '-' + $sidebarLg.css('width') }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: '0' }, { duration: 300, queue: false });
    }
  });
});
