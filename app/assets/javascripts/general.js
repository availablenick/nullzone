$(document).on('turbolinks:load', function() {

  $sidebarBg = $('.sidebar-bg');

  // Topbar behavior
  $(document).on('scroll', function() {
    let bannerHeight = $('.banner').css('height');
    bannerHeight = bannerHeight.slice(0, bannerHeight.length - 2);
    if (window.scrollY > bannerHeight) {
      $('.topbar').css('position', 'fixed');

      $sidebarBg.css('position', 'fixed');
      $sidebarBg.css('top', '0');
      $sidebarBg.css('margin-top', '50px');

      $('.main-wrapper').css('padding-top', '100px');
    } else {
      $('.topbar').css('position', 'relative');
      
      $sidebarBg.css('position', 'absolute');
      $sidebarBg.css('top', 'auto');
      $sidebarBg.css('margin-top', '0');
      
      $('.main-wrapper').css('padding-top', '50px');
    }
  });

  // Toggle sidebar
  $toggleBtn = $('.toggle-sidebar');
  $bar = $toggleBtn.find('.bar');
  $sidebarBg.click(function() {
    $('.sidebar').animate({ left: '-17%' }, 300, function() {
      $toggleBtn.removeClass('clicked');
      $toggleBtn.removeAttr('style');
      $bar.removeAttr('style');

      $sidebarBg.css('display', 'none');
    });
  });

  $toggleBtn.click(function() {
    if (!$toggleBtn.hasClass('clicked')) {
      $toggleBtn.addClass('clicked');
      $toggleBtn.css('background', 'white');
      $bar.css('background', 'black');
      $bar.eq(1).css('margin', '6px 0');
      $sidebarBg.css('display', 'block');
      $('.sidebar').animate({ left: '0' }, 300);
    } else {
      $('.sidebar').animate({ left: '-17%' }, 300, function() {
        $toggleBtn.removeClass('clicked');
        $toggleBtn.removeAttr('style');
        $bar.removeAttr('style');
        $sidebarBg.css('display', 'none');
      });
    }
  });
});
