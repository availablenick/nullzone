$(document).ready(function() {
  let $topbar = $('.topbar');
  let $sidebar = $('.sidebar-main-wrapper aside');
  let $main = $('main');
  let $banner = $('.banner');
  let $scrollingUpBtn = $('.scrolling-btns > button:first');
  let $scrollingDownBtn = $('.scrolling-btns > button:last');
  let $tooltips = $('.topbar .custom-tooltip');

  $scrollingUpBtn.click(function() {
    $('html').animate({ scrollTop: 0 }, 600);
  });

  $scrollingDownBtn.click(function() {
    $('html').animate({ scrollTop: $('html')[0].offsetHeight }, 600);
  });

  let topbarHeight = $topbar.css('height').slice(0, -2);
  let mainPadding = $main.css('padding').slice(0, -2);
  let bannerHeight = $banner.css('height').slice(0, -2);
  let sum = Number(topbarHeight) + Number(mainPadding);

  $(document).on('scroll', function() {
    if ($banner.css('display') !== 'none')
      heightToCompare = bannerHeight;
    else
      heightToCompare = 0;

    if (window.scrollY > heightToCompare) {
      $topbar.css('position', 'fixed');
      $sidebar.css('position', 'fixed');
      $sidebar.css('top', topbarHeight + 'px');
      $main.css('padding-top', sum + 'px');

      if (window.innerWidth >= 768) {
        $tooltips.css({
          'bottom': 'initial',
          'top': '110%'
        });

        $tooltips.removeClass('arrow-md-below');
        $tooltips.addClass('arrow-md-above');
      }
    } else {
      $topbar.css('position', 'relative');
      $sidebar.css('position', 'absolute');
      $sidebar.css('top', 'auto');

      if (window.innerWidth >= 768) {
        $tooltips.removeAttr('style');
        $tooltips.removeClass('arrow-md-above');
        $tooltips.addClass('arrow-md-below');
      }

      $main.css('padding-top', $main.css('padding-bottom'));
    }
  });
});
