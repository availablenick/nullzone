function quote(index, element) {
  element.addEventListener('click', () => {
    let msgBox = document.getElementById('text-box');
    text = msgBox.value;
    let itsOp = 0;
    if (element.dataset.post === "none") {
      element.dataset.post = element.dataset.topic;
      itsOp = 1;
    }

    msgBox.value = text +
      '[quote'
      + ' code=' + element.dataset.post + '/' + element.dataset.topic + '/' + itsOp
      + ' author=' + element.dataset.author
      + ']'
      + element.dataset.msg
      + '[/quote]';
  });
}

$(document).on('turbolinks:load', function() {
  let $body = $("body").first();
  if ( $body.hasClass('topics') && $body.hasClass('show') ) {
    $(".msg-text").each(function() {
      replaceTags(this);
    });

    /* $(document).on('ajax:send', function() {
      alert('Processando...');
    }); */

    // Add quoting function
    $(".quote-btn").each(quote);

    // Quote link redirect workaround
    if (window.location.hash) {
      window.location.href = window.location.href;
    }
  }
});
