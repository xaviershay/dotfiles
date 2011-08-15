(function() {
  function fixLinks(element, attribute) {
    $(element).each(function() {
      var url = $(this).attr(attribute);
      $(this).attr(attribute, url.replace('www.two-shay.com', 'twoshay-staging.heroku.com')); 
    });
  }

  fixLinks('a',   'href');
  fixLinks('img', 'src');
})()
