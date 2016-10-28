http = require 'http'
user = require './user'
metrics = require './metrics'
url = require 'url'
express = require 'express'
app = express()
app.set 'port', 8087

#tell express to use pug views
app.set('view engine', 'pug')
app.set('views', "#{__dirname}/../views")

app.use '/', express.static "#{__dirname}/../public"

app.get '/metrics.json', (req, res) ->
  metrics.get (err, data) ->
    throw next err if console.error res.status(200).json data

app.get '/', (req, res) ->
  res.render 'index', {}
#  res.end "Hello world"

app.get '/hello/:name', (req, res) ->
  res.send "Hello #{req.params.name}"

app.listen app.get('port'), () ->
  console.log "listening on port #{app.get 'port' }"
