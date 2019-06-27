# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', () =>
  # Envio de arquivo
  div_file_chooser = document.querySelector('.file-chooser')
  if div_file_chooser != null
    file_input = document.querySelector('input[type="file"]')
    div_file_chooser.addEventListener 'click', () =>
      click_event = new MouseEvent('click')
      file_input.dispatchEvent(click_event)
    
    filename = file_input.value
    if filename != ''
      filename = filename.replace(/(.*\\)+/, '')
      div_file_chooser.innerText = 'Arquivo selecionado: ' + filename

    file_input.addEventListener 'change', () =>
      filename = file_input.value
      if filename != ''
        filename = filename.replace(/(.*\\)+/, '')
        div_file_chooser.innerText = 'Arquivo selecionado: ' + filename
      else
        div_file_chooser.innerText = 'Escolher arquivo'
  
  # Substitui o link do video pela versão 'embed'
  post_form = document.querySelector('#post-form')
  if post_form != null
    video_field = document.querySelector('#post_video')
    post_form.addEventListener 'submit', () =>
      link = video_field.value
      if link != ''
        link = link.replace('watch?v=', 'embed/')
        video_field.value = link

  body = document.querySelector('body')
  if (body.classList.contains('topicos') && (body.classList.contains('index') ||
      body.classList.contains('search')))

    avatar_divs = Array.from(document.querySelectorAll('.avatar-div'))
    avatar_divs.forEach (div) =>
      parent_style = window.getComputedStyle(div.parentNode)
      div.style.lineHeight = parent_style.getPropertyValue('height')
