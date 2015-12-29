express = require "express"
uploader = require "./lib/uploader"
generator = require "./lib/generator"

TWITTER_URL = "https://twitter.com/dunckr"
PORT = 3000

app = express()
app.set("port", process.env.PORT ? PORT)
app.listen(app.get("port"))

app.get "/", (req, res) ->
  generator (data) ->
    uploader data, ->
      res.redirect TWITTER_URL
