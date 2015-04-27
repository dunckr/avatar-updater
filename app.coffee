express = require "express"
fs = require "fs"
path = require "path"
hbs = require "hbs"
bodyParser = require "body-parser"
Twit = require "twit"
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
    res.setHeader("Content-Type", "text/plain")
    res.write("Error: #{JSON.stringify(err)}")
    res.write("Response: #{JSON.stringify(data)}")
    res.end()

app.post "/bg", (req, res) ->
  url = "http://colorfulgradients.tumblr.com/random"
