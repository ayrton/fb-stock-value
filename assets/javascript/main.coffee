jQuery ($) ->
  displayQuote = (data) ->
    change = data[0].c
    changepercent = data[0].cp
    current = data[0].l
    $("#current span").html current

  getQuote = ->
    $.ajax
      url: "http://www.google.com/finance/info?client=ig&q=FB"
      success: (data) ->
        displayQuote eval(data)

      error: ->
        console.log "Retrieving data didn't work"

      dataType: "jsonp"

  getQuote()
  setInterval getQuote, 5000