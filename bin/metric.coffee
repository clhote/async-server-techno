#!/bin/bash coffee
metric = require '../src/metrics'

met0 = [
  timestamp:(new Date '2013-12-09 16:00 UTC').getTime(), value:10
,
  timestamp:(new Date '2013-12-09 16:50 UTC').getTime(), value:12
]

met1 = [
  timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:15
,
  timestamp:(new Date '2013-11-04 14:10 UTC').getTime(), value:18
]

met2 = [
  timestamp:(new Date '2014-11-04 14:00 UTC').getTime(), value:14
,
  timestamp:(new Date '2014-11-04 14:10 UTC').getTime(), value:15
]

met3 = [
  timestamp:(new Date '2016-11-04 14:00 UTC').getTime(), value:13
,
  timestamp:(new Date '2016-11-04 14:10 UTC').getTime(), value:16
]



metric.save 0, met0, (err) ->
  throw err if err
  console.log 'Metrics saved'

metric.save 1, met1, (err) ->
  throw err if err
  console.log 'Metrics saved'

metric.save 2, met2, (err) ->
  throw err if err
  console.log 'Metrics saved'

metric.save 3, met3, (err) ->
  throw err if err
  console.log 'Metrics saved'
