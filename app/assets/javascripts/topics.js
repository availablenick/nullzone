$(document).ready(function() {
  $goToPage = $('.goto-page');
  $goToPageSpan = $('.goto-page > span');

  $(document).click(function(event) {
    for (let div of $goToPage.toArray()) {
      if (event.target === $(div).find('> span')[0])
        return;
      
      $box = $(div).find('.box');
      if (event.target !== $box[0] && !$.contains($box[0], event.target)) {
        if ($box.css('display') !== 'none') {
          $box.fadeOut(200);
          break;
        }
      }
    }
  });

  $goToPageSpan.click(function() {
    if ($(this).parent().find('.box').css('display') === 'none') {
      $(this).parent().find('.box').fadeIn(200);
    } else {
      $(this).parent().find('.box').fadeOut(200);
    }
  });
});
