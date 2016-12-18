should = require 'should'
metrics = require '../src/metrics'
shortId = require 'shortid'

id = '10'
metric = [
  timestamp:(new Date '2013-11-04 14:00 UTC').getTime(), value:32
,
  timestamp:(new Date '2013-11-04 14:10 UTC').getTime(), value:33
,
  timestamp:(new Date '2013-11-04 17:00 UTC').getTime(), value:39
,
  timestamp:(new Date '2013-11-04 18:10 UTC').getTime(), value:34
]

describe 'test metrics CRUD module', ()->
  it 'should add a metric batch', (done)->
    metrics.save id, metric, (err)->
      should(err).equal(undefined)
      done()

  it 'should get metrics', (done)->
    metrics.get id, (err, res)->
      should(res).be.an.Array()
      should(res).not.have.length(0)
      should(err).equal(null)
      res.forEach (metric)->
        should(metric).have.property('id').which.is.equal(id)
      done()

  it 'should delete a batch', (done)->
    metrics.remove id, (err)->
      should(err).equal(null)
      metrics.get id, (err, res)->
        should(res.length).equal(0)
        done()

  it 'should not find deleted batch', (done) ->
    metrics.get id, (err, metricId) ->
      metricId.should.be.an.Object()
      metricId.should.be.empty()

      done()
