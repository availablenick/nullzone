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
    $box = $(this).parent().find('.box');
    for (let div of $goToPage.toArray()) {
      $divBox = $(div).find('.box');
      if ($divBox[0] !== $box[0]) {
        $divBox.fadeOut(200);
      }
    }

    if ($box.css('display') === 'none') {
      $box.fadeIn(200);
    } else {
      $box.fadeOut(200);
    }
  });
});
