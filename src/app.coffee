ttp = require 'http'
user = require './user'
metrics = require './metrics'
url = require 'url'
express = require 'express'
bodyparser = require 'body-parser'

app = express()

app.set 'port', 8086

urljsonParser =  bodyparser.json()
urlencodedParser = bodyparser.urlencoded({extended:true})

#tell express to use pug views
app.set('view engine', 'pug')
app.set('views', "#{__dirname}/../views")

app.use '/', express.static "#{__dirname}/../public"


app.get "/metrics(/:id)?", (req, res) ->
  metrics.get req.params.id, (err, data) ->
    throw next err if err
    res.status(200).json data

app.post "/metrics/:id", urlencodedParser, (req, res) ->
  metrics.save req.params.id, req.body, (err) ->
    throw next err if err
    res.status(200).send()

app.delete "/metrics(/:id)?", (req, res) ->
  metrics.remove req.params.id, (err) ->
    throw next err if err
    res.status(200).send()

app.get '/', (req, res) ->
  res.render 'index', {}
#  res.end "Hello world"

app.get '/hello/:name', (req, res) ->
  res.send "Hello #{req.params.name}"

app.listen app.get('port'), () ->
  console.log "listening on port #{app.get 'port' }"
