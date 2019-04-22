# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery
$.fn.showChart = (chart_data) ->

  # Fill data
  yaxis_data = []
  series_data = []

  for o, i in chart_data
    for m, v of o
      # Create multiple yAxis
      yaxis_data.push
        title:
          text: m
        opposite:
          if i % 2 is 0 then false else true
        reversed:
          reversed = if m is 'Compete' then true else false
      # Fill the data
      now = new Date
      month_ago = new Date 1900+now.getYear(), now.getMonth()-1, now.getDay()
      series_data.push
        name: m
        pointInterval: 86400000 # 1 day
        pointStart: month_ago.getTime()
        yAxis: i
        data: v

  # Show the chart
  new Highcharts.Chart
    chart:
      renderTo: 'chart'
    title:
      text: 'Rating by Day'
    plotOptions:
      series:
        animation: false
    xAxis:
      type: 'datetime'
    yAxis:
      yaxis_data
    series:
      series_data
