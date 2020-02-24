$(document).on('turbolinks:load', function() {

  // Topbar behavior
  $(document).on('scroll', function() {
    let bannerHeight = $('.banner').css('height');
    bannerHeight = bannerHeight.slice(0, bannerHeight.length - 2);
    if (window.scrollY > bannerHeight) {
      $('.topbar').css('position', 'fixed');
      $('.main-wrapper').css('padding-top', '100px');
    } else {
      $('.topbar').css('position', 'relative');
      $('.main-wrapper').css('padding-top', '50px');
    }
  })
});
