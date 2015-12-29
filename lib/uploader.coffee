Twit = require "twit"
Constants = require "./constants"
URL = "account/update_profile_banner"

module.exports = (body, cb) ->
  b64 = new Buffer(body).toString("base64")
  T = new Twit(Constants)
  T.post URL, banner: b64, -> cb()
