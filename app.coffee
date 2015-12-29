express = require "express"
cheerio = require "cheerio"
request = require "request"
Twit = require "twit"
Constants = require "./private/constants"

PORT = 3000
TWITTER_URL = "https://twitter.com/dunckr"
T = new Twit(Constants)

app = express()
app.set("port", process.env.PORT ? PORT)
app.listen(app.get("port"))

app.get "/", (req, res) ->
  getRandomBg (imgUrl) ->
    request { url: imgUrl, encoding: null}, (err, r, body) ->
      uploadImg body, ->
        res.redirect TWITTER_URL

uploadImg = (body, cb) ->
  b64 = new Buffer(body).toString("base64")
  URL = "account/update_profile_banner"
  T.post URL, banner: b64, -> cb()

getRandomBg = (cb) ->
  URL = "http://colorfulgradients.tumblr.com/random"
  request URL, (err, res, html) ->
    $ = cheerio.load(html)
    imgUrl = $(".photo-wrapper img").first().attr("src")
    cb(imgUrl)
