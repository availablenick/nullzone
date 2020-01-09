replaceColor = (parent, msg, startOfMsg, openStartIndex, openEndIndex,
                closeStartIndex, closeEndIndex) => {
  let leadingText = msg.slice(startOfMsg, openStartIndex);
  let middleText = msg.slice(openEndIndex, closeStartIndex);
  let trailingText = msg.slice(closeEndIndex);
  let tag = msg.slice(openStartIndex, openEndIndex);
  let code = /code=([^\]]+)/g.exec(tag)[1];
  let span = document.createElement('SPAN');
  
  span.style.color = code;
  span.appendChild(document.createTextNode(middleText));
  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(leadingText));
  parent.appendChild(span);
  parent.appendChild(document.createTextNode(trailingText));
};

replaceLink = (parent, msg, startOfMsg, openStartIndex, openEndIndex,
                closeStartIndex, closeEndIndex) => {
  let leadingText = msg.slice(startOfMsg, openStartIndex);
  let middleText = msg.slice(openEndIndex, closeStartIndex);
  let trailingText = msg.slice(closeEndIndex);
  let tag = msg.slice(openStartIndex, openEndIndex);
  let ref = /\ref=([^\]]+)/g.exec(tag)[1];
  let anchor = document.createElement('A');

  anchor.setAttribute('href', ref);
  anchor.appendChild(document.createTextNode(middleText));
  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(leadingText));
  parent.appendChild(anchor);
  parent.appendChild(document.createTextNode(trailingText));
};

replaceSpoiler = (parent, msg, startOfMsg, openStartIndex, openEndIndex,
                closeStartIndex, closeEndIndex) => {
  let leadingText = msg.slice(startOfMsg, openStartIndex);
  let middleText = msg.slice(openEndIndex, closeStartIndex);
  let trailingText = msg.slice(closeEndIndex);
  let span = document.createElement('SPAN');

  span.classList.add('spoiler');
  span.style.padding = "0 3px 0";
  span.appendChild(document.createTextNode(middleText));
  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(leadingText));
  parent.appendChild(span);
  parent.appendChild(document.createTextNode(trailingText));
};

replaceVideo = (parent, msg, startOfMsg, openStartIndex, openEndIndex,
                closeStartIndex, closeEndIndex) => {
  let leadingText = msg.slice(startOfMsg, openStartIndex);
  let trailingText = msg.slice(closeEndIndex);
  let tag = msg.slice(openStartIndex, openEndIndex);
  let link = /ref=([^\]]+)/g.exec(tag)[1];
  let newLink = link.replace('watch?v=', 'embed/');

  let frame = document.createElement('IFRAME');
  frame.setAttribute('height', 400);
  frame.setAttribute('src', newLink);
  frame.setAttribute('frameborder', 0);

  let videoDiv = document.createElement('SPAN');
  videoDiv.classList.add('video');
  videoDiv.appendChild(frame);

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(leadingText));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(videoDiv);
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createElement('BR'));
  parent.appendChild(document.createTextNode(trailingText));
};

replaceTags = (parent) => {
  let text = parent.childNodes[0].textContent;
  let i = 0;
  while (i < text.length) {
    if (text[i] === '[') {
      let tagName = '';
      let j = i+1;

      // It must not find a close tag
      if (text[j] === '/') {
        i++;
        continue;
      }

      while (text[j] !== ' ' && text[j] !== ']') {
        tagName += text[j];
        j++;
      }

      let regex = new RegExp('\\[\\/?' + tagName + '.*?\\]', 'g');
      regex.lastIndex = i; // To ignore already checked tags
      let match = regex.exec(text);
      let openTagStartIndex = match.index;
      let openTagEndIndex = regex.lastIndex;

      // Find matching close tag if there is one
      let tagsWithoutPair = 1;
      if (!hasClosure[tagName])
        tagsWithoutPair = 0;
   
      while (tagsWithoutPair > 0) {
        match = regex.exec(text);
        if (match === null)
          break;
        
        if (match[0][1] !== '/') {
          tagsWithoutPair++;
        } else {
          tagsWithoutPair--;
        }
      }
      
      // tira isso aqui fi
      console.log("tag name: " + tagName);
      console.log("tag with no pair: " + tagsWithoutPair);
      console.log("slice open: ", text.slice(openTagStartIndex, openTagEndIndex));
      if (tagsWithoutPair === 0) {
        let closeTagStartIndex = match.index;
        let closeTagEndIndex = regex.lastIndex;
        if (tagName !== 'quote') {
          functions[tagName](parent, text, 0, openTagStartIndex, openTagEndIndex,
                             closeTagStartIndex, closeTagEndIndex);
          i = 0;
          text = text.slice(closeTagEndIndex);
          continue;
        }
        
        let leadingText = text.slice(0, openTagStartIndex);
        let middleText = text.slice(openTagEndIndex, closeTagStartIndex);
        let trailingText = text.slice(closeTagEndIndex);
        let tagText = text.slice(openTagStartIndex, openTagEndIndex);
        let m = /author=([^\]]+)/g.exec(tagText);
        if (!m) {
          i = 0;
          text = text.slice(closeTagEndIndex);
          continue;
        }

        let author = /author=([^\]]+)/g.exec(tagText)[1];
        
        // Link to quoted post
        let postLink = document.createElement('A');
        postLink.setAttribute('href', '#');
        postLink.addEventListener('click', (event) => {
          event.preventDefault();
          document.location.hash = '';
          document.location.hash = '#';
        });
        
        postLink.appendChild(document.createTextNode(author + ':'));
        
        // Quote header
        let divHead = document.createElement('DIV');
        divHead.classList.add('head');
        divHead.appendChild(postLink);
        
        // Put the text in div and replace quote tags recursively
        let divContent = document.createElement('DIV');
        divContent.classList.add('content');
        divContent.appendChild(document.createTextNode(middleText));
        replaceTags(divContent);
        
        // Put all in quote
        let newQuote = document.createElement('DIV');
        newQuote.classList.add('quote');
        newQuote.appendChild(divHead);
        newQuote.appendChild(divContent);
        
        // Remove quote tag text and append new children
        parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
        parent.appendChild(document.createTextNode(leadingText));
        parent.appendChild(newQuote);
        parent.appendChild(document.createElement('BR'));
        parent.appendChild(document.createElement('BR'));
        parent.appendChild(document.createTextNode(trailingText));
        
        i = 0;
        text = text.slice(closeTagEndIndex);
        continue;
      }
    }

    i++;
  }
};

let hasClosure = {
  color: true,
  link: true,
  quote: true,
  spoiler: true,
  video: false,
}

let functions = {
  color: replaceColor,
  link: replaceLink,
  spoiler: replaceSpoiler,
  video: replaceVideo
};
