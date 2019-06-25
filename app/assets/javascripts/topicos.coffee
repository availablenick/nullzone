# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', () =>
  body = document.querySelector('body')
  if ((body.classList.contains('topicos') && (body.classList.contains('show') ||
      body.classList.contains('new'))) || 
      (body.classList.contains('posts') && body.classList.contains('edit')))

    divs = document.querySelectorAll('.post-wrapper')
    divs = Array.from(divs)
    divs.forEach (div) =>
      ps = div.getElementsByClassName('user-post-space')[0]
      user_msg_div = ps.getElementsByClassName('user-msg')[0]

      img_element = null
      Array.from(user_msg_div.children).every (child, index) =>
        if child.tagName == 'IMG'
          img_element = child
          return false
        else
          return true

      if img_element != null
        img_element.addEventListener 'load', () =>
          div_style = window.getComputedStyle(div)
          parent_style = window.getComputedStyle(div.parentNode)
          
          height = parseFloat(div_style.getPropertyValue('height'))
          parent_height = parseFloat(parent_style.getPropertyValue('height'))
          if height < 0.43 * parent_height
            div.style.height = div_style.getPropertyValue('min-height')
      else
        div_style = window.getComputedStyle(div)
        parent_style = window.getComputedStyle(div.parentNode)
        
        height = parseFloat(div_style.getPropertyValue('height'))
        parent_height = parseFloat(parent_style.getPropertyValue('height'))
        if height < 0.43 * parent_height
          div.style.height = div_style.getPropertyValue('min-height')

    post_spaces = document.querySelectorAll('.user-post-space')
    post_spaces = Array.from(post_spaces)
    post_spaces.forEach (ps) =>
      parent = ps.parentNode
      if (ps.style.height < parent.style.height)
        ps.style.height = '100%'

    div_file_chooser = document.querySelector('.file-chooser')
    if div_file_chooser != null
      file_input = document.querySelector('input[type="file"]')
      div_file_chooser.addEventListener 'click', () =>
        click_event = new MouseEvent('click')
        file_input.dispatchEvent(click_event)
    
      file_input.addEventListener 'change', () =>
        filename = file_input.value
        if filename != ''
          filename = filename.replace(/(.*\\)+/, '')
          div_file_chooser.innerText = 'Arquivo selecionado: ' + filename
        else
          div_file_chooser.innerText = 'Escolher arquivo'
