fs = require 'fs'
_ = require 'underscore'
assert = require('chai').assert
request = require 'superagent'


FILE_NAME = './data/test.json'


describe "Test API", ->
  beforeEach (done) ->
    data = JSON.stringify({})
    fs.writeFile FILE_NAME, data, 'utf8', -> done()
    return

  it "GET /api/test: should PASS", (done) ->
    # given
    data = JSON.stringify({'mode': 0})
    fs.writeFile FILE_NAME, data, 'utf8', (err) ->
      if err
        return done(err)
      # when
      request.get('http://127.0.0.1:3000/api/test')
        .end (error, res) ->
          # then
          if error
            return done(error)
          assert.equal(res.status, 200)
          assert.typeOf(res.body['mode'], 'number')
          assert.equal(res.body['mode'], 0)
          done()
          return
      return
    return

  it "GET /api/test: should FAIL", (done) ->
    # given
    data = JSON.stringify({'mode': 0})
    fs.writeFile FILE_NAME, data, 'utf8', (err) ->
      if err
        return done(err)
      # when
      request.get('http://127.0.0.1:3000/api/testtest')
        .end (error, res) ->
          # then
          if error
            return done(error)
          assert.equal(res.status, 200)
          assert.notOk(_.has(res.body, 'mode'))
          done()
          return
      return
    return

  it "POST /api/test: should PASS", (done) ->
    # given
    # N/A
    # when
    request.post('http://127.0.0.1:3000/api/test')
      .send({'mode': 0})
      .set('Content-type', 'application/json')
      .end (error, res) ->
        # then
        if error
          return done(error)
        assert.equal(res.status, 200)
        assert.typeOf(res.body['mode'], 'number')
        assert.equal(res.body['mode'], 0)
        done()
        return
    return

  it "DELETE /api/test: should PASS", (done) ->
    # given
    data = JSON.stringify({'mode': 0})
    fs.writeFile FILE_NAME, data, 'utf8', (err) ->
      if err
        return done(err)
      # when
      request.del('http://127.0.0.1:3000/api/test/mode')
        .end (error, res) ->
          # then
          if error
            return done(err)
          assert.equal(res.status, 200)
          assert.typeOf(res.body['mode'], 'undefined')
        done()
        return
      return
    return

  it "DELETE /api/test: should FAIL", (done) ->
    # given
    data = JSON.stringify({'mode': 0})
    fs.writeFile FILE_NAME, data, 'utf8', (err) ->
      if err
        return done(err)
      # when
      request.del('http://127.0.0.1:3000/api/test/hoge')
        .end (error, res) ->
          # then
          if error
            return done(err)
          assert.equal(res.status, 200)
          assert.typeOf(res.body['hoge'], 'undefined')
        done()
        return
      return
    return
