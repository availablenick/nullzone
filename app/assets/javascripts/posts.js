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

$(document).ready(function() {
  let $body = $("body").first();
  if ( $body.hasClass('topics') && $body.hasClass('show') ) {
    $(".msg-text").each(function() {
      replaceTags(this);
    });

    // Add quoting function
    $(".quote-btn").each(quote);
  }
});
