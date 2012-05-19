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
        displayQuote data
        $('#current').addClass('show')

      error: ->
        console.log "Retrieving quote data didn't work"
        $('#current').addClass('error')

      dataType: "jsonp"

  displayChart = (data) ->
    console.log "displayChart"
    console.log data

  getChartData = ->
    limitResults = "30"
    quoteSymbol = "AAPL"
    now = new Date()
    month = now.getMonth() + 1
    # now.getMonth() returns 0-11 instead of 00-11, if one digit, prepend with 0
    if month.length = 1
      month = "0" + month

    today = "#{now.getFullYear()}-#{month}-#{now.getDate()}"
    console.log today + " " + quoteSymbol
    chartUrl = "http://query.yahooapis.com/v1/public/yql?q=select%20date%2C%20Close%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22"+quoteSymbol+"%22%20and%20startDate%20%3D%20%222012-05-17%22%20and%20endDate%20%3D%20%22"+today+"%22%20limit%20"+limitResults+"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
    $.ajax
      url: chartUrl
      success: (data) ->
        displayChart data

      error: ->
        console.log "Retrieving chart data didn't work"

      dataType: "jsonp"

  getQuote()
  setInterval getQuote, 5000
  getChartData()