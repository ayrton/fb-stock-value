// Generated by CoffeeScript 1.3.1
(function() {

  jQuery(function($) {
    var displayQuote, getQuote;
    displayQuote = function(data) {
      var change, changepercent, current;
      change = data[0].c;
      changepercent = data[0].cp;
      current = data[0].l;
      return $("#current span").html(current);
    };
    getQuote = function() {
      return $.ajax({
        url: "http://www.google.com/finance/info?client=ig&q=FB",
        success: function(data) {
          displayQuote(eval(data));
          return $('#current').addClass('show');
        },
        error: function() {
          console.log("Retrieving data didn't work");
          return $('#current').addClass('error');
        },
        dataType: "jsonp"
      });
    };
    getQuote();
    return setInterval(getQuote, 5000);
  });

}).call(this);
