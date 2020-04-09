function setUpModal(fadeOnSubmit) {
  // Show up modal and give it focus
  $modal = $('.custom-modal');
  $modal.focus();

  $modalBox = $('.modal-box');
  $modalBox.css('top', '-50%');

  // Downslide effect
  $modalBox.animate({ top: '30%' }, 500);

  // Prevent click bubbling
  $modal.children().click(function(event) {
    event.stopPropagation();
  });

  // Close modal with fade out effect
  function makeFadeOut(event) {
    if (event.type === 'click' || event.type === 'keydown' && event.keyCode === 27) {
      $modalBox.removeAttr('style');
      $modalBox.animate({ opacity: 0 }, 300, function() {
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
