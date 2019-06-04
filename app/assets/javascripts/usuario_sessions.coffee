# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.addEventListener 'load', () ->
  submit_btn = document.querySelector("input[type='submit'")

  submit_btn.addEventListener "mousedown", () ->
    @style.backgroundColor = '#888'
    @style.borderColor = '#888'

  submit_btn.addEventListener "mouseup", () ->
    @style.backgroundColor = '#aaa'
    @style.borderColor = '#aaa'

  submit_btn.addEventListener "mouseenter", () ->
    @style.backgroundColor = '#999'
    @style.borderColor = '#999'

  submit_btn.addEventListener "mouseout", () ->
    @style.backgroundColor = '#aaa'
    @style.borderColor = '#aaa'
