should = require('should')
user = require('../src/user')
db = require("#{__dirname}/../src/db")("#{__dirname}/../db/test")


user1 = {
  username: "Bob80",
  name: "Bobby",
  password: "test",
  email: "bob75@bob.fr"
}

describe 'test user CRUD module', () ->


  it 'should save a user', (done) ->
    user.save user1.username, user1, (err) ->
      should.not.exist err
      done()

  it 'should get a user', (done) ->
    user.get user1.username, (err, user) ->
      should(err).equal(null)
      should(user.username).equal user1.username
      should(user.name).equal user1.name
      should(user.password).equal user1.password
      should(user.email).equal user1.email
      done()

  it 'should delete a user', (done) ->
    user.delete user1.username, (err) ->
      should(err).equal(null)
      done()

  it 'should not find deleted user', (done) ->
    user.get user1.username, (err, user) ->
      user.should.be.an.Object()
      user.should.be.empty()

      done()
