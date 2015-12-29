request = require "request"
cheerio = require "cheerio"
URL = "http://colorfulgradients.tumblr.com/random"

module.exports = (cb) ->
  request URL, (err, res, html) ->
    $ = cheerio.load(html)
    imgUrl = $(".photo-wrapper img").first().attr("src")
    options =
      url: imgUrl
      encoding: null
    request options, (err, r, body) -> cb(body)
