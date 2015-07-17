express = require "express"
cheerio = require "cheerio"
request = require "request"
Twit = require "twit"
Constants = require "./private/constants"

T = new Twit(Constants)

app = express()
app.set("port", process.env.PORT ? 3000)
app.listen(app.get("port"))

app.get "/", (req, res) ->
  getRandomBg (imgUrl) ->
    request { url: imgUrl, encoding: null}, (err, r, body) ->
      uploadImg body, ->
        res.redirect "https://twitter.com/dunckr"

uploadImg = (body, cb) ->
  b64 = new Buffer(body).toString("base64")
  T.post "account/update_profile_banner", banner: b64, (err, data) -> cb()

getRandomBg = (cb) ->
  url = "http://colorfulgradients.tumblr.com/random"
  request url, (err, res, html) ->
    $ = cheerio.load(html)
    $(".photo-wrapper img").each ->
      imgUrl = $(this).attr("src")
      cb(imgUrl)

