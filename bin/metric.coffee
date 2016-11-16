#!/bin/bash coffee
metric = require '../src/metrics'
met = [
  timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:14
,
  timestamp:(new Date '2013-11-04 14:10 UTC').getTime(), value:15
]

metric.put 1, met, (err) ->
  throw err if err
  console.log 'Metrics saved'
