# A way to interact with the Google Images API.
#
# mtg me <query>    - return the Gatherer image for the named card
#
module.exports = (robot) ->
  robot.respond /mtg( me)? (.*)/i, (msg) ->
    mtgMe msg, msg.match[2], (url) ->
      msg.send url

mtgMe = (msg, cardName, cb) ->
  encodedCardName = encodeURIComponent(cardName)
  cb "http://gatherer.wizards.com/Handlers/Image.ashx?name=#{encodedCardName}&type=card#.png"

