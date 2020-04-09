$(document).ready(function() {
  // Searching options
  $searchingForm = $('form.searching');
  $searchingInput = $searchingForm.find('input[type="text"]');

  // Large screen at least
  $searchingOptions = $searchingForm.find('.options');
  $radio1 = $('input.r1');
  $radio2 = $('input.r2');
  $radioSpan1 = $('.radio-span.r1');
  $radioSpan2 = $('.radio-span.r2');
  $radioCircle1 = $radioSpan1.find('.radio-selected');
  $radioCircle2 = $radioSpan2.find('.radio-selected');

  $searchingInput.click(function() {
    if (window.innerWidth >= 992) {
      if ($searchingOptions.css('display') === 'none') {
        $searchingOptions.show();
      }
    }
  });

  $radioSpan1.click(function() {
    $radio1[0].checked = true;
    $radio2[0].checked = false;
    $radioCircle1.show();
    $radioCircle2.hide();
  });

  $radioSpan2.click(function() {
    $radio1[0].checked = false;
    $radio2[0].checked = true;
    $radioCircle1.hide();
    $radioCircle2.show();
  });

  // Medium screen at most
  $openSearchBtn = $('.open-search');
  $closeSearchBtn = $('.close-search');
  $cover = $searchingForm.find('.cover');

  $searchingInput.focus(function() {
    if (window.innerWidth < 992) {
      $(this).parent().css('border-bottom-color', 'rgb(0, 115, 255)');
    }
  });

  $searchingInput.blur(function() {
    if (window.innerWidth < 992) {
      $(this).parent().css('border-bottom-color', 'rgba(0, 100, 255, 0.5)');
    }
  });

  $openSearchBtn.click(function() {
    $searchingForm.css('display', 'flex');
    $searchingInput.focus();
  });

  $closeSearchBtn.click(function() {
    $searchingForm.hide();
  });

  $cover.click(function() {;
    $searchingForm.hide();
  });

  // Logged in user's options window
  $loggedInDiv = $('.logged-in');
  if ($loggedInDiv[0]) {
    $optionsToggle = $loggedInDiv.find('.wrapper');
    $optionsWindow = $loggedInDiv.find('.options');

    $optionsToggle.click(function() {
      if ($optionsWindow.css('display') === 'none') {
        $optionsToggle.css('background', '#333');
        $optionsWindow.show();
      } else {
        $optionsToggle.removeAttr('style');
        $optionsWindow.hide();
      }
    });
  }

  // Handle clicks on document to close floating windows
  $(document).click(function() {
    // Searching options
    if ($cover.css('display') === 'none') {
      if ($searchingForm[0] !== event.target && !$.contains($searchingForm[0], event.target)) {
        if ($searchingOptions.css('display') !== 'none') {
          $searchingOptions.hide();
        }
      }
    }

    // Logged in user's options
    if ($loggedInDiv[0] && $optionsWindow.css('display') !== 'none') {
      if (event.target !== $optionsToggle[0] && !$.contains($optionsToggle[0], event.target)) {
        if (event.target !== $optionsWindow[0] && !$.contains($optionsWindow[0], event.target)) {
          $optionsToggle.removeAttr('style');
          $optionsWindow.hide();
        }
      }
    }
  });
});
