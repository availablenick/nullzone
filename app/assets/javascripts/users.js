$(document).ready(function() {
  $body = $('body');
  if ( $body.hasClass('users') && ($body.hasClass('new') || $body.hasClass('edit')) ) {
    $filePicker = $('.file-picker');
    $input = $('input[type="file"]');
    $filePicker.on('click', function() {
      $input.click();
    });

    filename = ''
    $input.on('change', function() {
      filename = $input.val();
      if (filename !== '') {
        filename = filename.replace(/(.*\\)+/, '');
        $filePicker.text('Imagem selecionada: ' + filename);
      } else {
        $filePicker.text('Escolher imagem');
      }
    });
  }
});
