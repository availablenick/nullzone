$(document).ready(function() {
  let $sidebarCoverWrapper = $('.sidebar-main-wrapper > aside');
  let $sidebar = $sidebarCoverWrapper.find('div:first-child');
  let $cover = $sidebarCoverWrapper.find('.cover');
  let $mainContent = $('.main-content');

  if (window.innerWidth >= 992) {
    sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState && sidebarState === 'visible') {
      $sidebarCoverWrapper.show();
      $sidebar.css('left', '0');
      $mainContent.css('margin-left', '10rem');
    }
  }

  $cover.click(function() {
    $sidebar.animate({ left: '-' + $sidebar.css('width') }, 300, function() {
      localStorage.setItem('sidebarState', 'hidden');
      $sidebarCoverWrapper.hide();
      $mainContent.removeAttr('style');
    });
  });

  // Toggle sidebar
  let $toggleBtn = $('.toggle-sidebar');
  $toggleBtn.click(function() {
    if (window.innerWidth < 992) {
      localStorage.setItem('sidebarState', 'visible');
      $sidebarCoverWrapper.show();
      $sidebar.animate({ left: '0' }, 300);
      $mainContent.css('margin-left', '10rem');
      return;
    }

    sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState === 'hidden' || !sidebarState) {
      localStorage.setItem('sidebarState', 'visible');
      $sidebarCoverWrapper.show();
      $sidebar.animate({ left: '0' }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: $sidebar.css('width') }, { duration: 300, queue: false });
    } else {
      localStorage.setItem('sidebarState', 'hidden');
      $sidebar.animate({ left: '-' + $sidebar.css('width') }, { duration: 300, queue: false });
      $mainContent.animate({ marginLeft: '0' },
        {
          duration: 300,
          queue: false,
          done: function() {
            $sidebarCoverWrapper.hide();
            $mainContent.removeAttr('style');
          }
        }
      );
    }
  });
});
