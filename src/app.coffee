http = require ("http")
user = require ('./user')
server = http.createServer (req, res) ->
  user.get 'Caroline', (id) ->
    res.writeHead 200, 'Content-Type': 'text/plain'
    res.end 'Hello ' + id
.listen 1337

console.log("Server is listening.");
