/* document.addEventListener('turbolinks:load', () => {
  body = document.querySelector('body');
  if (body.classList.contains('topicos') && (body.classList.contains('index') ||
      body.classList.contains('search'))) {

    let avatarDivs = Array.from(document.querySelectorAll('.avatar-div'));
    for (let div of avatarDivs) {
      parent_style = window.getComputedStyle(div.parentNode);
      div.style.lineHeight = parent_style.getPropertyValue('height');
    }
  }
}); */
