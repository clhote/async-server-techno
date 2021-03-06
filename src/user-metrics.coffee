db = require('./db')("#{__dirname}/../db/user_metrics")

module.exports =
  save:(username, metricId, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    ws.write
      key: "user_metrics:#{username}:#{metricId}"
      value: "#{metricId}"
    console.log username + " " + metricId
    ws.end()


  get: (username, callback) ->
    user_metric = []
    rs = db.createReadStream
      start: "user_metrics:#{username}"
    rs.on 'data', (data) ->
      [_, _key, _] = data.key.split ':'
      if _key == username
        user_metric.push
          username: username
          metricId: data.value
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user_metric


remove: (username, callback) ->
  ws = db.createWriteStream()
  ws.on 'error', callback
  ws.on 'close', callback
  ws.write
    type:"del"
    key: "user_metrics:#{username}"
  ws.end()
