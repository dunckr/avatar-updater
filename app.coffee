express = require "express"
fs = require "fs"
path = require "path"
Twit = require "twit"
Constants = require "./private/constants"

T = new Twit(Constants.Twitter)
app = express()
app.set("port", process.env.PORT || 3000)

app.get "/", (req, res) ->
  imgPath = path.join(__dirname, "assets/profile.jpg")
  fs.readFile imgPath, encoding: "base64", (err, b64) ->
    T.post "account/update_profile_image", image: b64, (err, data, res) ->
      console.log err, data

app.listen app.get("port")
