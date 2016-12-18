http = require 'http'
user = require './user'
metrics = require './metrics'
user_metrics = require './user-metrics'
url = require 'url'
express = require 'express'
bodyparser = require 'body-parser'
morgan = require 'morgan'
session = require 'express-session'
LevelStore = require('level-session-store')(session)
errorHandler = require 'errorhandler'
app = express()
server = require('http').Server(app)
io = require('socket.io')(server)

sockets = []
idMetric = 4;

if process.env.NODE_ENV == 'development'
  #only use in development
  app.use(errorhandler())


io.on 'connection', (socket) ->
  sockets.push socket

app.use morgan 'dev'
app.set 'port', 8081

urljsonParser =  bodyparser.json()
urlencodedParser = bodyparser.urlencoded({extended:true})

#tell express to use pug views
app.set('view engine', 'pug')
app.set('views', "#{__dirname}/../views")

app.use '/', express.static "#{__dirname}/../public"

app.use session
  secret: 'MyAppSecret'
  store: new LevelStore '../db/sessions'
  resave: true
  saveUninitialized: true

#Render login view
app.get '/login', (req, res) ->
  console.log (req.session.username)
  res.render 'login'

#Render signup view
app.get '/signup', (req, res) ->
  res.render 'signup'

#Authorization : check if login and password matches and get loggedin
app.post '/login', urlencodedParser, (req, res) ->
  user.get req.body.username, (err, data) ->
    console.log (data)
    return next err if err
    if req.body.password == data.password
      req.session.loggedIn = true
      req.session.username = data.username
      res.redirect '/'
    else
      res.redirect '/login'

#Get the list of all users
app.get '/list/:username', (req, res) ->
  user.get req.params.username, (err, data) ->
    throw next err if err
    res.status(200).json data

#Add a new user
app.post '/signup', urlencodedParser, (req, res) ->
  user.get req.body.username, (err, data) ->
    if data.username == req.body.username
      console.log "ERROR Il existe deja un user ayant ce username"
    else
      user.save req.body.username, req.body, (err) ->
        throw next err if err
        res.status(200).send()
        res.redirect 'login'

#logging out a user
app.get '/logout', (req, res) ->
  delete req.session.loggedIn
  delete req.session.username
  res.redirect '/login'

#delete a user
app.delete '/list/:username', (req, res) ->
  user.delete req.params.username, (err) ->
    throw next err if err
    res.status(200).send()

#Logging middleware
app.use (req, res, next) ->
  for socket in sockets
    socket.emit 'logs',
      username:
        if req.session.username == undefined then 'anonymous'
        else req.session.username
      url: req.url
  next()

#Middleware checking user authentication
authCheck = (req, res, next) ->
  unless req.session.loggedIn == true
    res.redirect '/login'
  else
    next()


app.get '/', authCheck, (req, res) ->
  res.render 'index', name : req.session.username

app.get '/logs', (req, res) ->
  res.render 'log'

#Get a metric batch
app.get "/metrics(/:id)?", (req, res) ->
  metrics.get req.params.id, (err, data) ->
    throw next err if err
    res.status(200).json data

#Save a metric batch
app.post "/metrics/:id", urlencodedParser, (req, res) ->
  metrics.save req.params.id, req.body, (err) ->
    throw next err if err
    res.status(200).send()

#Remove a metric batch
app.delete "/metrics(/:id)?", (req, res) ->
  metrics.remove req.params.id, (err) ->
    throw next err if err
    res.status(200).send()

#Get user's metric batches
app.get '/umetrics', (req, res) ->
    user_metrics.get req.session.username, (err, data) ->
      throw next err if err
      res.status(200).json data

#Get user's metric batch by id
app.get '/umetrics/:id', (req, res) ->
    metrics.get req.params.id, (err, data) ->
      throw next err if err
      res.status(200).json data

#Post user's metric batch
app.post '/umetrics', urlencodedParser, (req, res) ->
  metrics.save idMetric, req.body, (err) ->
    throw next err if err
    res.status(200).send()
  user_metrics.save req.session.username, idMetric, (err) ->
    throw next err if err
    idMetric++
    res.status(200).send()
  res.redirect('back')

#Delete a specific user batch
app.delete "/umetrics/:id", (req, res) ->
  user_metrics.remove req.session.username, (err) ->
    throw next err if err
    res.status(200).send()
  metrics.remove req.params.id, (err) ->
    throw next err if err
    res.status(200).send()


server.listen app.get('port'), ->
    console.log "listening on port #{app.get 'port'}"

#app.listen app.get('port'), () ->
#  console.log "listening on port #{app.get 'port' }"
