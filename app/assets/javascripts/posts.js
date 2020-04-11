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

function setUpQuoteLink(index, element) {
  let href = $(element).attr('href');
  let anchor = '';
  if (href.indexOf('#') > -1) {
    anchor = href.slice(href.indexOf('#'), href.length)
  } else {
    r = /posts\//g;
    m = r.exec(href);
    anchor = '#' + href.slice(r.lastIndex, href.length);
  }

  if ($(anchor).length > 0) {
    $(element).click(function(event) {
      event.preventDefault();

      if (window.location.hash != anchor)
        window.history.pushState(null, '', anchor);

      $('html').animate({ scrollTop: $(anchor)[0].offsetTop }, 500);
    });
  }
}

$(document).ready(function() {
  let $body = $("body").first();
  if ( $body.hasClass('topics') && $body.hasClass('show') ) {
    // Set up quote's link
    $('.quote > .header > a').each(setUpQuoteLink);

    // Add quoting function
    $(".quote-btn").each(quote);
  }
});
