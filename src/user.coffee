db = require('./db')("#{__dirname}/../db/user")

module.exports =

#Get a user by username
  get: (username, callback) ->
    user = {}
    rs = db.createReadStream
      start: "user:#{username}:"
    rs.on 'data', (data) ->
      [_, _username, _key] = data.key.split ':'
      username = username;
      if _username == username
        [_, _username, _key] = data.key.split ':'
        username= _username;
        value= data.value
        user["#{_key}"] = value
        console.log user
    rs.on 'error', callback
    rs.on 'close', ->
      callback null, user

#Save a user with its info

  # opts :
  #   password: ...
  #   email: ...
  #   name: ...
  save: (username, opts, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    for k, v of opts
      ws.write
        key: "user:#{username}:#{k}"
        value: v
    ws.end()


#Delete a user by username
  delete: (username, callback) ->
    ws = db.createWriteStream()
    ws.on 'error', callback
    ws.on 'close', callback
    ws.write
      type:"del"
      key: "user:#{username}"
    ws.end()
