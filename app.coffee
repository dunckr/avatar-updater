express = require "express"
fs = require "fs"
path = require "path"
hbs = require "hbs"
bodyParser = require "body-parser"
Twit = require "twit"
cheerio = require "cheerio"
request = require "request"
Constants = require "./private/constants"

T = new Twit(Constants.Twitter)

app = express()
app.use(bodyParser.json(limit: "50mb"))
app.set("port", process.env.PORT || 3000)
app.use(express.static(path.join(__dirname, "/build")))

app.listen(app.get("port"))

app.post "/avatar", (req, res) ->
  b64Original = req.body.b64
  b64 = b64Original.replace(/^data:image\/png;base64,/, "")
  T.post "account/update_profile_image", image: b64, (err, data) ->
    console.log err, data

app.get "/bg", (req, res) ->
  getRandomBg (imgUrl) ->
    request { url: imgUrl, encoding: null}, (err, res, body) ->
      b64 = new Buffer(body).toString("base64")
      T.post "account/update_profile_banner", banner: b64, (err, data) ->
        console.log err, data

getRandomBg = (cb) ->
  url = "http://colorfulgradients.tumblr.com/random"
  request url, (err, res, html) ->
    $ = cheerio.load(html)
    $(".photo-wrapper img").each ->
      imgUrl = $(this).attr("src")
      cb(imgUrl)

