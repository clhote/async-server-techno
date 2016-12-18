#!/bin/bash coffee
metric = require '../src/metrics'
user_metrics = require '../src/user-metrics'
user = require '../src/user'

met0 = [
  timestamp:(new Date '2013-12-11 16:00 UTC').getTime(), value:1
,
  timestamp:(new Date '2014-02-05 16:50 UTC').getTime(), value:3
,
  timestamp:(new Date '2014-04-18 17:00 UTC').getTime(), value:10
,
  timestamp:(new Date '2014-06-12 20:50 UTC').getTime(), value:5
,
]

met1 = [
  timestamp:(new Date '2014-11-04 14:00 UTC').getTime(), value:12
,
  timestamp:(new Date '2014-12-04 14:10 UTC').getTime(), value:18
,
  timestamp:(new Date '2015-01-04 14:30 UTC').getTime(), value:15
,
  timestamp:(new Date '2015-02-04 14:50 UTC').getTime(), value:14
]

met2 = [
  timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:24
,
  timestamp:(new Date '2013-11-04 14:10 UTC').getTime(), value:27
,
  timestamp:(new Date '2013-11-04 15:00 UTC').getTime(), value:21
,
  timestamp:(new Date '2013-11-04 16:10 UTC').getTime(), value:29
]

met3 = [
  timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:32
,
  timestamp:(new Date '2013-11-04 14:10 UTC').getTime(), value:33
,
  timestamp:(new Date '2013-11-04 17:00 UTC').getTime(), value:39
,
  timestamp:(new Date '2013-11-04 18:10 UTC').getTime(), value:34
]

user1 = {
  username:'caro', password:'123', name:'Caroline', email:'clhote@ece.fr'
}

user2 = {
  username:'gaby', password:'azerty', name:'Gabriel', email:'gdesportes@ece.fr'
}


user.save "caro", user1, (err) ->
  throw err if err
  console.log "user1 saved"

user.save "gaby", user2 , (err) ->
  throw err if err
  console.log "user2 saved"

metric.save 0, met0, (err) ->
  throw err if err
  console.log 'Metrics saved'


user_metrics.save "caro" , 0, (err) ->
  throw err if err
  console.log 'user_metrics ok'

metric.save 1, met1, (err) ->
  throw err if err
  console.log 'Metrics saved'

user_metrics.save "caro", 1, (err) ->
  throw err if err
  console.log 'user_metrics ok'

metric.save 2, met2, (err) ->
  throw err if err
  console.log 'Metrics saved'

user_metrics.save "gaby", 2, (err) ->
  throw err if err
  console.log 'user_metrics ok'

metric.save 3, met3, (err) ->
  throw err if err
  console.log 'Metrics saved'

user_metrics.save "gaby", 3, (err) ->
  throw err if err
  console.log 'user_metrics ok'
