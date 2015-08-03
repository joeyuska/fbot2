# UrbanDictionary definitions with the UrbanDictionary API.
#
# urban me <word> - Grabs a dictionary definition of a word.

module.exports = (robot) ->
  # Word definition
  robot.respond /urban( me)? (.*)/i, (msg) ->
    word = msg.match[2]
    
    msg.send word

    fetch_urban_resource(msg, word, {}) (err, res, body) ->
      definitions = JSON.parse(body)

      msg.send definitions.list[0].definition

fetch_urban_resource = (msg, word, query, callback) ->
    
  msg.http("http://api.urbandictionary.com/v0/define?term=#{escape(word)}")
    .get(callback)