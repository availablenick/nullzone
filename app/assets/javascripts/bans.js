$(document).ready(function() {
  $body = $('body');
  if ( $body.hasClass('bans') && ($body.hasClass('new') || $body.hasClass('edit')) ) {
    $checkbox = $('input[type="checkbox"]');
    $dateInput = $('input[type="datetime-local"]');
    if ($checkbox[0].checked) {
      $dateInput.attr('disabled', 'disabled');
    }

    dateValue = $dateInput.val();
    $checkbox.click(function() {
      if (this.checked) {
        $dateInput.attr('disabled', 'disabled');
        $dateInput.val('');
      } else {
        $dateInput.removeAttr('disabled');
        $dateInput.val(dateValue);
      }
    });
  }
});
