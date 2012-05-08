http = require 'http'
urlParser = require 'url'

url = 'http://freegeoip.net/json/'

exports.lookup = (ip, callback) ->

  request = result = ''
  parsedUrl = urlParser.parse url, true
  path = parsedUrl.pathname + ip

  #console.log 'requesting: '+parsedUrl.host+path

  request = http.request
    host: parsedUrl.host
    port: parsedUrl.port
    path: path
    , (res) ->
      res.on 'data', (chunk) ->
        result += chunk
      res.on 'end', ->
        if res.statusCode == 200
          callback(null, JSON.parse(result), res.statusCode)
        else
          callback('Could not resolve URL: '+parsedUrl.href+' - '+res.statusCode)
  
  request.on 'error', (error) ->
    callback(error)

  request.end()