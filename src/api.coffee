fs = require 'fs'
_ = require 'underscore'
express = require 'express'
bodyParser = require 'body-parser'
deferred = require 'deferred'
app = express()
app.use(bodyParser())


DATA_PATH = './data/'


# Routing
app.get '/', (req, res) ->
  res.type('text/plain')
  res.send('hello:)')
  return


app.get '/api/:key', (req, res) ->
  key = req.params.key
  readModel(key)
  .then (data) ->
    if _.isNull(data)
      res.send('NOT FOUND')
    else
      res.type('application/json')
      res.json(data)
  return

 
app.post '/api/:key', (req, res, next) ->
  key = req.params.key
  if not _.isObject(req.body) then return res.send('INVALID DATA')
  readModel(key)
  .then (data) ->
    if _.isNull(data)
      data = {}
    resBody = _.extend(data, req.body)
    writeModel(key, JSON.stringify(resBody))
    .then (data) ->
      res.type('application/json')
      res.json(resBody)
    , (err) ->
      res.send(err)
  return


app.delete '/api/:key/:json_key', (req, res, next) ->
  key = req.params.key
  jsonKey = req.params.json_key
  if not _.isObject(req.body) then return res.send('INVALID DATA')
  readModel(key)
  .then (data) ->
    if _.isNull(data) or not _.has(data, jsonKey)
      res.send('NOT FOUND')
    resBody = _.omit(data, jsonKey)
    writeModel(key, JSON.stringify(resBody))
    .then (data) ->
      res.type('application/json')
      res.json(resBody)
    , (err) ->
      res.send(err)
  return


# I/O
readModel = (key) ->
  dfd = deferred()
  fileName = DATA_PATH + key + '.json'
  fs.readFile fileName, 'utf8', (err, data) ->
    if err
      resBody = null
    try
      resBody = JSON.parse(data)
    catch e
      console.warn e
      resBody = null
    dfd.resolve(resBody)
  return dfd.promise


writeModel = (key, data) ->
  dfd = deferred()
  fileName = DATA_PATH + key + '.json'
  fs.writeFile fileName, data, 'utf8', (err) ->
    if err
      return dfd.reject('I/O ERROR')
    dfd.resolve(data)
  return dfd.promise


app.listen(process.env.PORT or 3000)
