replaceVideo = (parent, msg, beginIndex, endIndex) => {
  let split1 = msg.slice(0, beginIndex);
  let split2 = msg.slice(endIndex);
  let tag = msg.slice(beginIndex, endIndex);

  let link = /\=[^\]]+/g.exec(tag)[0].slice(1);
  let newLink = link.replace('watch?v=', 'embed/');

  let frame = document.createElement('IFRAME');
  frame.setAttribute('height', 400);
  frame.setAttribute('src', newLink);
  frame.setAttribute('frameborder', 0);

  let videoDiv = document.createElement('SPAN');
  videoDiv.classList.add('video');
  videoDiv.appendChild(frame);

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(split1));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(videoDiv);
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createTextNode(split2));
};

replaceLink = (parent, msg, beginIndex, endIndex) => {
  let split1 = msg.slice(0, beginIndex);
  let split2 = msg.slice(endIndex);
  let tag = msg.slice(beginIndex, endIndex);

  let ref = /\=[^\]]+/g.exec(tag)[0].slice(1);
  let link = /\][^\[]+/g.exec(tag)[0].slice(1);

  let anchor = document.createElement('A');
  anchor.setAttribute('href', ref);
  anchor.appendChild(document.createTextNode(link));

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(split1));
  parent.appendChild(anchor);
  parent.appendChild(document.createTextNode(split2));
};

replaceSpoiler = (parent, msg, beginIndex, endIndex) => {
  let split1 = msg.slice(0, beginIndex);
  let split2 = msg.slice(endIndex);
  let tag = msg.slice(beginIndex, endIndex);

  console.log('tag: ' + tag);

  let text = /\][^\[]+/g.exec(tag)[0].slice(1);

  let span = document.createElement('SPAN');
  span.classList.add('spoiler');
  span.appendChild(document.createTextNode(text));

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(split1));
  parent.appendChild(span);
  parent.appendChild(document.createTextNode(split2));
};

replaceTags = (parent, tags, functions) => {
  let text = parent.childNodes[0].textContent;
  let i = 0;
  while (i < text.length) {
    if (text[i] == '[') {
      for (let [key, value] of Object.entries(tags)) {
        tags[key].lastIndex = 0;
        let match = value.exec(text);

        if (match && match.index == i) {
          let lastIndex = value.lastIndex;

          if (key != 'quote') {
            functions[key](parent, text, match.index, value.lastIndex);
          } else {
            // Texto antes e depois da tag
            let split1 = text.slice(0, match.index);
            let split2 = text.slice(value.lastIndex);

            // Pega os ids
            let postMatch = /=\d+/g.exec(match[0]);
            let postId = postMatch[0].slice(1);
            let topicoMatch = /\/\d+/g.exec(match[0]);
            let topicoId = topicoMatch[0].slice(1);

            // Busca dados do post quotado
            let post = null;
            let xhttp = new XMLHttpRequest()
            xhttp.onreadystatechange = () => {
              if (xhttp.readyState == XMLHttpRequest.DONE &&
                  xhttp.status == 200) {

                post = JSON.parse(xhttp.responseText);
              }
            };

            xhttp.open(
              'GET',
              '/topicos/' + topicoId + '/posts/' + postId,
              false
            );
            xhttp.setRequestHeader('Content-Type', 'application/json');
            xhttp.send();

            // Link para o post quotado
            let postLink = document.createElement("A");
            postLink.setAttribute('href', '#' + postId);
            postLink.addEventListener('click', (event) => {
              event.preventDefault();
              document.location.hash = '';
              document.location.hash = '#' + postId;
            });

            postLink.appendChild(document.createTextNode(post.usuario.login + ':'));

            // Header do quote
            let divHead = document.createElement('DIV');
            divHead.classList.add('head');
            divHead.appendChild(postLink);

            // Coloca o texto na div e substitui tags de quote recursivamente
            let divContent = document.createElement('DIV');
            divContent.classList.add('content');
            divContent.appendChild(document.createTextNode(post.mensagem));
            replaceTags(divContent, tags, functions);

            // Coloca tudo no quote
            let newQuote = document.createElement('DIV');
            newQuote.classList.add('quote');
            newQuote.appendChild(divHead);
            newQuote.appendChild(divContent);

            // Remove o texto com a tag do quote e coloca os novos filhos
            parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
            parent.appendChild(document.createTextNode(split1));
            parent.appendChild(document.createElement('BR'));
            parent.appendChild(newQuote);
            parent.appendChild(document.createElement('BR'));
            parent.appendChild(document.createTextNode(split2));
          }

          text = text.slice(lastIndex);
          i = -1;
          break;
        }
      }
    }

    i++;
  }
};

let tags = {
  quote: /\[quote code=\d+\/\d+\]/g,
  video: /\[video ref=.+\]/g,
  link: /\[link ref=.+\].+\[link\]/g,
  spoiler: /\[spoiler\].+\[spoiler\]/g
};

let functions = {
  video: replaceVideo,
  link: replaceLink,
  spoiler: replaceSpoiler
};
