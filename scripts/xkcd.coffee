# Description:
#   Embeds an XKCD comic, and then posts the alt text.
#
# Dependencies:
#   None
#
# Configuration:
#   None
# 
# Commands:
#   http://xkcd.com/* - Detects the XKCD comic, extracts the image, posts it and then the summary.
#
# Author:
#   @yahelc

module.exports = (robot) ->
  robot.hear /http:\/\/xkcd\.com\/(\d+)?\/?/i, (msg) ->
    code = msg.match[1] || ""
    msg
      .http("http://xkcd.com/#{code}/info.0.json")
      .headers(Accept: "application/json")
      .get() (err, res, body) ->
        unless res.statusCode is 200
          msg.send "XKCD comic #{code} not found"
          return

        comic = JSON.parse body
        msg.send comic.title + ": " + comic.alt
        msg.send comic.img
