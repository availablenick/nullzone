document.addEventListener('turbolinks:load', () => {
  let body = document.querySelector('body');
  if ( body.classList.contains('users') &&
    (body.classList.contains('new') || body.classList.contains('edit')) ) {

    let filePicker = document.getElementsByClassName('file-picker')[0]
    let input = document.querySelector('input[type="file"]');
    filePicker.addEventListener('click', () => {
      let clickEvent = new MouseEvent('click');
      input.dispatchEvent(clickEvent);
    });

    let filename = ''
    input.addEventListener('change', () => {
      filename = input.value;
      if (filename !== '') {
        filename = filename.replace(/(.*\\)+/, '');
        filePicker.innerText = 'Imagem selecionada: ' + filename;
      } else {
        filePicker.innerText = 'Escolher imagem';
      }
    });
  }
});
