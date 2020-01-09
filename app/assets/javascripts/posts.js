document.addEventListener('turbolinks:load', () => {
  let body = document.querySelector('body');
  if ((body.classList.contains('topicos') && body.classList.contains('show')) ||
      (body.classList.contains('posts') && body.classList.contains('create'))) {

    // Tag replacement
    let msgDivs = document.getElementsByClassName('msg-text');
    for (let div of msgDivs) {
      replaceTags(div);
    }

    // Fix post divs sizes
    postDivs = document.getElementsByClassName('post-wrapper');
    for (let div of postDivs) {
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
    };

    // Post removal confirmation
    let deleteBtns = document.getElementsByClassName('delete-btn');
    let closeModalBtn = document.getElementsByClassName('close-modal')[0];
    let modalDelete = document.getElementsByClassName('modal-del')[0];
    let modalWrapper = document.getElementsByClassName('modal-wrapper')[0];
    let ansBtns = modalDelete.getElementsByTagName('BUTTON');
    modalWrapper.addEventListener('animationend', () => {
      if (modalWrapper.classList.contains('modal-fade')) {
        modalDelete.style.display = 'none';
        modalWrapper.classList.remove('modal-fade');
      }
    });

    ansBtns[0].addEventListener('click', () => {
      modalWrapper.classList.add('modal-fade');
    });
    
    closeModalBtn.addEventListener('click', () => {
      modalWrapper.classList.add('modal-fade');
    });
    
    window.addEventListener('click', event => {
      if (event.target === modalDelete) {
        modalWrapper.classList.add('modal-fade');
      }
    });
        
    for (let btn of deleteBtns) {
      btn.addEventListener('click', () => {
        modalDelete.style.display = 'block';
        let form = modalDelete.getElementsByTagName('FORM')[0];
        form.setAttribute('action', btn.dataset.url);
      });
    }

    // Add-quote button
    let quoteBtns = document.getElementsByClassName('quote-btn');
    for (let btn of quoteBtns) {
      btn.addEventListener('click', () => {
        let msgBox = document.getElementById('msg-box');
        text = msgBox.value;
        msgBox.value = text +
                       '[quote code=' + btn.dataset.post + '/' +
                        btn.dataset.topico + ' author=' + btn.dataset.author +
                       ']' + btn.dataset.msg +'[/quote]';
          
        document.location.hash = '';
        document.location.hash = '#post-sending';
      });
    }


    // File sending
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
