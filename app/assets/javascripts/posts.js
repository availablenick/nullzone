document.addEventListener('turbolinks:load', () => {
  let body = document.querySelector('body');
  if ((body.classList.contains('topicos') && body.classList.contains('show')) ||
      (body.classList.contains('posts') && body.classList.contains('create'))) {

    // Substituição de tags
    let msgDivs = document.getElementsByClassName('msg-text');
    for (let div of Array.from(msgDivs)) {
      replaceTags(div, tags, functions);
    }

    // Botão para adicionar quote
    let quoteBtns = document.getElementsByClassName('quote-btn');
    for (let btn of Array.from(quoteBtns)) {
      btn.addEventListener('click', () => {
        let msgBox = document.getElementById('msg-box');
        text = msgBox.value;
        if (text === '') {
          msgBox.value = '[quote code=' + btn.dataset.post + '/' + btn.dataset.topico + ']';
        } else {
          msgBox.value = text + '\n' + '[quote code=' + btn.dataset.post + '/' + btn.dataset.topico + ']';
        }
          
        document.location.hash = '';
        document.location.hash = '#post-sending';
      });
    }

    // Arruma as dimensões das divs do post
    divs = document.getElementsByClassName('post-wrapper');
    divs = Array.from(divs);
    divs.forEach(div => {
      let ps = div.getElementsByClassName('user-post-space')[0];
      let userMsgDiv = ps.getElementsByClassName('user-msg')[0];

      let imgElement = null;
      for (let child of Array.from(userMsgDiv.children)) {
        if (child.tagName === 'IMG') {
          imgElement = child;
          break;
        }
      }

      if (imgElement !== null) {
        imgElement.addEventListener('load', () => {
          let divStyle = window.getComputedStyle(div);
          let parentStyle = window.getComputedStyle(div.parentNode);
          
          let height = parseFloat(divStyle.getPropertyValue('height'));
          let parentHeight = parseFloat(parentStyle.getPropertyValue('height'));
          if (height < 0.43 * parentHeight) {
            div.style.height = divStyle.getPropertyValue('min-height');
          }
        });
      } else {
        let divStyle = window.getComputedStyle(div);
        let parentStyle = window.getComputedStyle(div.parentNode);
        
        let height = parseFloat(divStyle.getPropertyValue('height'));
        let parentHeight = parseFloat(parentStyle.getPropertyValue('height'));
        if (height < 0.43 * parentHeight) {
          div.style.height = divStyle.getPropertyValue('min-height');
        }
      }
    });

    // Envio de arquivo
    let divFileChooser = document.querySelector('.file-chooser');
    if (divFileChooser !== null) {
      let fileInput = document.querySelector('input[type="file"]');
      divFileChooser.addEventListener('click', () => {
        let clickEvent = new MouseEvent('click');
        fileInput.dispatchEvent(clickEvent);
      });

      let filename = fileInput.value;
      if (filename !== '') {
        filename = filename.replace(/(.*\\)+/, '');
        divFileChooser.innerText = 'Arquivo selecionado: ' + filename;
      }

      fileInput.addEventListener('change', () => {
        filename = fileInput.value;
        if (filename !== '') {
          filename = filename.replace(/(.*\\)+/, '');
          divFileChooser.innerText = 'Arquivo selecionado: ' + filename;
        } else {
          divFileChooser.innerText = 'Escolher arquivo';
        }
      });
    }
  }
});
