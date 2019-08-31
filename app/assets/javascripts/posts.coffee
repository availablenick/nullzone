# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

replaceVideo = (parent, msg, beginIndex, endIndex) =>
  split1 = msg.slice(0, beginIndex)
  split2 = msg.slice(endIndex)

  tag = msg.slice(beginIndex, endIndex)

  link = /\=[^\]]+/g.exec(tag)[0].slice(1)
  newLink = link.replace('watch?v=', 'embed/')

  frame = document.createElement('IFRAME')
  frame.setAttribute('height', 400)
  frame.setAttribute('src', newLink)
  frame.setAttribute('frameborder', 0)

  videoDiv = document.createElement('SPAN')
  videoDiv.classList.add('video')
  videoDiv.appendChild(frame)

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1])
  parent.appendChild(document.createTextNode(split1))
  parent.appendChild(document.createElement('BR'))
  parent.appendChild(videoDiv)
  parent.appendChild(document.createElement('BR'))
  parent.appendChild(document.createElement('BR'))
  parent.appendChild(document.createElement('BR'))
  parent.appendChild(document.createTextNode(split2))

replaceLink = (parent, msg, beginIndex, endIndex) =>
  split1 = msg.slice(0, beginIndex)
  split2 = msg.slice(endIndex)

  tag = msg.slice(beginIndex, endIndex)

  ref = /\=[^\]]+/g.exec(tag)[0].slice(1)
  link = /\][^\[]+/g.exec(tag)[0].slice(1)

  anchor = document.createElement('A')
  anchor.setAttribute('href', ref)
  anchor.appendChild(document.createTextNode(link))

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1])
  parent.appendChild(document.createTextNode(split1))
  parent.appendChild(anchor)
  parent.appendChild(document.createTextNode(split2))

replaceTags = (parent, tags, functions) =>
  text = ""
  Array.from(parent.childNodes).forEach (child) =>
    if child.nodeType == Node.TEXT_NODE
      text = child.textContent

  i = 0
  currentTag = null
  while i < text.length
    if text[i] == '['
      for key, value of tags
        tags[key].lastIndex = 0
        match = value.exec(text)
        if match && match.index == i
          lastIndex = value.lastIndex

          if key != 'quote'
            functions[key](parent, text, match.index, value.lastIndex)
          else
            # Texto antes e depois da tag
            split1 = text.slice(0, match.index)
            split2 = text.slice(value.lastIndex)

            # Pega os ids
            postMatch = /=\d+/g.exec(match[0])
            postId = postMatch[0].slice(1)
            topicoMatch = /\/\d+/g.exec(match[0])
            topicoId = topicoMatch[0].slice(1)

            # Busca dados do post quotado
            post = null
            xhttp = new XMLHttpRequest()
            xhttp.onreadystatechange = () =>
              if (xhttp.readyState == XMLHttpRequest.DONE &&
                  xhttp.status == 200)
                post = JSON.parse(xhttp.responseText)

            xhttp.open(
              'GET',
              '/topicos/' + topicoId + '/posts/' + postId,
              false
            );
            xhttp.setRequestHeader('Content-Type', 'application/json');
            xhttp.send();

            # Link para o post quotado
            postLink = document.createElement("A")
            postLink.setAttribute('href', '#' + postId)
            postLink.addEventListener 'click', (event) =>
              event.preventDefault()
              document.location.hash = ''
              document.location.hash = '#' + postId

            postLink.appendChild(document.createTextNode(post.usuario.login + ':'))

            # Header do quote
            divHead = document.createElement('DIV')
            divHead.classList.add('head')
            divHead.appendChild(postLink)

            # Coloca o texto na div e substitui tags de quote recursivamente
            divContent = document.createElement('DIV')
            divContent.classList.add('content')
            divContent.appendChild(document.createTextNode(post.mensagem))
            replaceTags(divContent, tags, functions)

            # Coloca tudo no quote
            newQuote = document.createElement('DIV')
            newQuote.classList.add('quote')
            newQuote.appendChild(divHead)
            newQuote.appendChild(divContent)

            # Remove o texto com a tag do quote e coloca os novos filhos
            parent.removeChild(parent.childNodes[parent.childNodes.length - 1])
            parent.appendChild(document.createTextNode(split1))
            parent.appendChild(document.createElement('BR'))
            parent.appendChild(newQuote)
            parent.appendChild(document.createElement('BR'))
            parent.appendChild(document.createTextNode(split2))
          
          text = text.slice(lastIndex)
          i = -1
          break

    i++

document.addEventListener 'turbolinks:load', () =>
  body = document.querySelector('body')
  if ((body.classList.contains('topicos') && body.classList.contains('show')) ||
      (body.classList.contains('posts') && body.classList.contains('create')))

    # Substituição de tags
    tags = {
      quote: /\[quote code=\d+\/\d+\]/g,
      video: /\[video ref=.+\]/g,
      link: /\[link ref=.+\].+\[link\]/g
    }

    functions = {
      video: replaceVideo
      link: replaceLink
    }

    msgDivs = document.getElementsByClassName('msg-text')
    Array.from(msgDivs).forEach (div) =>
      replaceTags(div, tags, functions)

    # Botão para adicionar quote
    quoteBtns = document.getElementsByClassName('quote-btn')
    Array.from(quoteBtns).forEach (btn) =>
      btn.addEventListener 'click', () =>
        msg_box = document.querySelector('#msg-box')
        text = msg_box.value
        if text == ''
          msg_box.value = '[quote code=' + btn.dataset.post + '/' + btn.dataset.topico + ']'
        else
          msg_box.value = text + '\n' + '[quote code=' + btn.dataset.post + '/' + btn.dataset.topico + ']'
          
        document.location.hash = ''
        document.location.hash = '#post-sending'

    # Arruma as dimensões das divs do post
    divs = document.getElementsByClassName('post-wrapper')
    divs = Array.from(divs)
    divs.forEach (div) =>
      ps = div.getElementsByClassName('user-post-space')[0]
      userMsgDiv = ps.getElementsByClassName('user-msg')[0]

      imgElement = null
      Array.from(userMsgDiv.children).every (child, index) =>
        if child.tagName == 'IMG'
          imgElement = child
          return false
        else
          return true

      if imgElement != null
        imgElement.addEventListener 'load', () =>
          divStyle = window.getComputedStyle(div)
          parentStyle = window.getComputedStyle(div.parentNode)
          
          height = parseFloat(divStyle.getPropertyValue('height'))
          parent_height = parseFloat(parentStyle.getPropertyValue('height'))
          if height < 0.43 * parent_height
            div.style.height = divStyle.getPropertyValue('min-height')
      else
        divStyle = window.getComputedStyle(div)
        parentStyle = window.getComputedStyle(div.parentNode)
        
        height = parseFloat(divStyle.getPropertyValue('height'))
        parent_height = parseFloat(parentStyle.getPropertyValue('height'))
        if height < 0.43 * parent_height
          div.style.height = divStyle.getPropertyValue('min-height')
