function setUpModal(fadeOnSubmit) {
  // Show up modal and give it focus
  $modal = $('.modal');
  $modalBox = $('.modal-box');

  $modal.css('display', 'flex');
  $modal.focus();

  // Downslide effect
  $modalBox.addClass('downslide');
  $modalBox.on('animationend', function() {
    $modalBox.removeClass('downslide');
    $modalBox.off('animationend');
  });

  // Prevent click bubbling
  $modal.children().click(function(event) {
    event.stopPropagation();
  });

  // Close modal with fade out effect
  function makeFadeOut(event) {
    if (event.type === 'click' || event.type === 'keydown' && event.keyCode === 27) {
      $modalBox.addClass('fade-out');

      $modalBox.on('animationend', function() {
        $modal.css('display', 'none');
        $modalBox.removeClass('fade-out');
        $modalBox.off('animationend');

        $('.modal + script').remove();
        $modal.remove();
      });
    }
  }
  
  $('.modal-close').click(makeFadeOut);
  $modal.click(makeFadeOut);
  $modal.on('keydown', makeFadeOut);
  if (fadeOnSubmit)
    $('.modal-submit').click(makeFadeOut);
}
