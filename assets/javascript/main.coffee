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

  

  getQuote()
  setInterval getQuote, 5000
  getChartData()


yahooIsLoaded = false
googleIsLoaded = false
parsedGraphData = []

yahooLoaded = (data) ->
  parseData(data)
  yahooIsLoaded = true
  allDataLoaded()

googleLoaded = ->
  googleIsLoaded = true
  allDataLoaded()

allDataLoaded = ->
  drawVisualization() if yahooIsLoaded and googleIsLoaded

parseData = (data) ->
  myResults = data.query.results.quote
  console.log myResults
  parsedGraphData.push [ "x", "Stock value" ]
  parsedGraphData.push ["2012-05-18 Start", parseFloat("38.00")]
  myResults = myResults.reverse() if myResults.length > 1
  _.each myResults, (quote) ->
    myfloat = parseFloat(quote.Close)
    parsedGraphData.push [quote.date, myfloat]


getChartData = ->
  limitResults = "30"
  quoteSymbol = "FB"
  now = new Date()
  month = now.getMonth() + 1
  if month.length = 1
    month = "0" + month

  today = "#{now.getFullYear()}-#{month}-#{now.getDate()}"
  chartUrl = "http://query.yahooapis.com/v1/public/yql?q=select%20date%2C%20Close%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22"+quoteSymbol+"%22%20and%20startDate%20%3D%20%222012-05-17%22%20and%20endDate%20%3D%20%22"+today+"%22%20limit%20"+limitResults+"&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
  $.ajax
    url: chartUrl
    success: yahooLoaded
    error: ->
      console.log "Retrieving chart data didn't work"

    dataType: "jsonp"



drawVisualization = ->
  data = google.visualization.arrayToDataTable(parsedGraphData)
  new google.visualization.LineChart(document.getElementById("chart")).draw data,
    curveType: "function"
    width: 740
    height: 200
    backgroundColor: "#3b5998"
    pointSize: 9
    axisTitlesPosition: "none"
    lineWidth: 3
    colors: [ "#7385b0" ]
    legend:
      position: "none"

    chartArea:
      width: "740"

    animation:
      duration: 1
      easing: "inAndOut"

    vAxis:
      gridlines:
        color: "#3b5998"

      textPosition: "none"
      baselineColor: "none"

    hAxis:
      textPosition: "none"
google.load "visualization", "1",
packages: [ "corechart" ]

google.setOnLoadCallback googleLoaded