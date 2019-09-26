document.addEventListener('turbolinks:load', () => {
   // Sidebar behavior
   let sidebarToggler = document.getElementsByClassName('sidebar-toggle')[0];
   let modalBar = document.getElementsByClassName('modal-bar')[0];
   let sidebar = document.getElementsByClassName('sidebar')[0];
   sidebarToggler.addEventListener('click', () => {
      if (window.getComputedStyle(modalBar).display === 'none') {
         modalBar.style.display = 'inline-block';
         sidebarToggler.style.backgroundColor = 'white';
         sidebarToggler.style.backgroundImage = 'url("/assets/menu_black.png")';
      } else {
         sidebar.classList.add('sidebar-hide');
         sidebarToggler.style.backgroundColor = '#444';
         sidebarToggler.style.backgroundImage = 'url("/assets/menu_white.png")';
      }
   });
   
   sidebar.addEventListener('animationend', () => {
      if (sidebar.classList.contains('sidebar-hide')) {
         modalBar.style.display = 'none';
         sidebar.classList.remove('sidebar-hide');
      }
   });

   window.addEventListener('click', event => {
      if (event.target === modalBar) {
         sidebar.classList.add('sidebar-hide');
         sidebarToggler.style.backgroundColor = '#444';
         sidebarToggler.style.backgroundImage = 'url("/assets/menu_white.png")';
      }
   });
});
