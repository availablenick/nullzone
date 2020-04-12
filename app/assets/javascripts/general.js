$(document).ready(function() {
  $topbar = $('.topbar');
  $sidebarLg = $('.sidebar-main-wrapper aside');
  $main = $('main');
  $banner = $('.banner');
  $scrollingUpBtn = $('.scrolling-btns > button:first');
  $scrollingDownBtn = $('.scrolling-btns > button:last');
  $tooltips = $('.topbar .custom-tooltip');

  $scrollingUpBtn.click(function() {
    $('html').animate({ scrollTop: 0 }, 600);
  });

  $scrollingDownBtn.click(function() {
    $('html').animate({ scrollTop: $('html')[0].offsetHeight }, 600);
  });

  topbarHeight = $topbar.css('height').slice(0, -2);
  mainPadding = $main.css('padding').slice(0, -2);
  bannerHeight = $banner.css('height').slice(0, -2);
  sum = Number(topbarHeight) + Number(mainPadding);

  $(document).on('scroll', function() {
    if ($banner.css('display') !== 'none')
      heightToCompare = bannerHeight;
    else
      heightToCompare = 0;

    if (window.scrollY > heightToCompare) {
      $topbar.css('position', 'fixed');
      if (window.innerWidth > 992) {
        $sidebarLg.css('position', 'fixed');
        $sidebarLg.css('top', topbarHeight + 'px');
      }

      $main.css('padding-top', sum + 'px');

      if (window.innerWidth > 768) {
        $tooltips.css({
          'bottom': 'initial',
          'top': '110%'
        });

        $tooltips.removeClass('arrow-md-below');
        $tooltips.addClass('arrow-md-above');
      }
    } else {
      $topbar.css('position', 'relative');
      if (window.innerWidth > 992) {
        $sidebarLg.css('position', 'absolute');
        $sidebarLg.css('top', 'auto');
      }

      if (window.innerWidth > 768) {
        $tooltips.removeAttr('style');
        $tooltips.removeClass('arrow-md-above');
        $tooltips.addClass('arrow-md-below');
      }

      $main.css('padding-top', $main.css('padding-bottom'));
    }
  });
});
