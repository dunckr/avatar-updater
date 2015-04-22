express = require "express"
Constants = require "./private/constants"

app = express()
app.set "port", process.env.PORT || 3000

app.get "/", (req, res) ->
  console.log "here"

app.listen app.get("port")
