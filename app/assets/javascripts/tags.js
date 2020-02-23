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
  frame.style.minWidth = '600px';
  frame.setAttribute('src', newLink);
  frame.setAttribute('frameborder', 0);

  let videoDiv = document.createElement('DIV');
  videoDiv.classList.add('video');
  videoDiv.appendChild(frame);

  parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
  parent.appendChild(document.createTextNode(leadingText));
  parent.appendChild(videoDiv);
  parent.appendChild(document.createTextNode(trailingText));
};

replaceTags = (parent) => {
  let text = parent.childNodes[0].textContent;
  let i = 0;
  while (i < text.length) {
    if (text[i] === '[') {
      let tagName = '';
      let j = i+1;

      // It must not find a closing tag
      if (text[j] === '/') {
        i++;
        continue;
      }

      while (text[j] !== ' ' && text[j] !== ']') {
        tagName += text[j];
        j++;
      }

      let regex = new RegExp('\\[\\/?' + tagName + '.*?\\]', 'g');
      regex.lastIndex = i; // Ignore already checked tags
      let match = regex.exec(text);
      let openTagStartIndex = match.index;
      let openTagEndIndex = regex.lastIndex;

      // Find match closing tag if there is one
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
        let codeMatch = /code=([^\] ]+)/g.exec(tagText);
        let authorMatch = /author=([^\] ]+)/g.exec(tagText);
        if (!codeMatch || !authorMatch) {
          i = 0;
          text = text.slice(closeTagEndIndex);
          continue;
        }

        let author = authorMatch[1];
        let code = codeMatch[1];
        let postId = code.slice(0, code.indexOf('/'));
        let topicId = code.slice(code.indexOf('/') + 1, code.indexOf('/', code.indexOf('/') + 1));
        let itsOp = code.slice(code.indexOf('/', code.indexOf('/') + 1) + 1, code.length);
        
        // Link to quoted post
        let postLink = document.createElement('A');
        if (itsOp !== '0') {
          postLink.setAttribute('href', '/topics/' + topicId + "#op-post");
        } else {
          postLink.setAttribute('href', '/posts/' + postId);
        }

        postLink.appendChild(document.createTextNode(author + ':'));
        
        // Quote header
        let divHead = document.createElement('DIV');
        divHead.classList.add('header');
        divHead.appendChild(postLink);
        
        // Put the text inside div and replace quote tags recursively
        let divContent = document.createElement('DIV');
        divContent.classList.add('content');
        divContent.appendChild(document.createTextNode(middleText));
        replaceTags(divContent);
        
        // Put all inside quote
        let newQuote = document.createElement('DIV');
        newQuote.classList.add('quote');
        newQuote.appendChild(divHead);
        newQuote.appendChild(divContent);
        
        // Remove quote tag text and append new children
        parent.removeChild(parent.childNodes[parent.childNodes.length - 1]);
        parent.appendChild(document.createTextNode(leadingText));
        parent.appendChild(newQuote);
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
