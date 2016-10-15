
should = require('should')
user = require('../src/user')

describe 'my first test list', ->

  it 'should return caroline (get)', ->
    user.get 'caroline',  (done) ->
      done.should.equal "caroline"

  it 'should not return caroline (get)', ->
    user.get 'test', (done) ->
      done.should.be.not.equal 'caroline'

  it 'should return caroline (save)', ->
    user.save 'caroline', (done) ->
      done.should.equal 'caroline'
