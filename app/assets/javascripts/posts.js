$(document).on('turbolinks:load', function() {
  let $body = $("body").first();
  if ( $body.hasClass('topics') && $body.hasClass('show') ) {
    $(".msg-text").each(function() {
      replaceTags(this);
    });

    /* $(document).on('ajax:send', function() {
      alert('Processando...');
    }); */

    // Add quoting button
    $(".quote-btn").each(function() {
      this.addEventListener('click', () => {
        let msgBox = document.getElementById('text-box');
        text = msgBox.value;
        let itsOp = 0;
        if (this.dataset.post === "none") {
          this.dataset.post = this.dataset.topic;
          itsOp = 1;
        }

        msgBox.value = text +
          '[quote'
          + ' code=' + this.dataset.post + '/' + this.dataset.topic + '/' + itsOp
          + ' author=' + this.dataset.author
          + ']'
          + this.dataset.msg
          + '[/quote]';
          
        document.location.hash = '';
        document.location.hash = '#post-place';
      });
    });

    // Quote link redirect workaround
    if (window.location.hash) {
      window.location.href = window.location.href;
    }
  }
});
