# Dictionary definitions with the Wordnik API. You'll need an API key from http://developer.wordnik.com/
#
# define me <word> - Grabs a dictionary definition of a word.
# pronounce me <word> - Links to a pronunciation of a word.
# spell me <word> - Suggests correct spellings of a possible word.

module.exports = (robot) ->
  # Word definition
  robot.respond /define( me)? (.*)/i, (msg) ->
    word = msg.match[2]
    
    fetch_wordnik_resource(msg, word, 'definitions', {}) (err, res, body) ->
      definitions = JSON.parse(body)
      
      if definitions.length == 0
        msg.send "No definitions for \"#{word}\" found."
      else
        reply = "Definitions for \"#{word}\":\n"
        lastSpeechType = null
        
        definitions = definitions.forEach (def) ->
          # Show the part of speech (noun, verb, etc.) when it changes
          if def.partOfSpeech != lastSpeechType
            reply += " (#{def.partOfSpeech})\n" if def.partOfSpeech != undefined

          # Track the part of speech
          lastSpeechType = def.partOfSpeech

          # Add the definition
          reply += "  - #{def.text}\n"
        
        msg.send reply

  # Pronunciation
  robot.respond /(pronounce|enunciate)( me)? (.*)/i, (msg) ->
    word = msg.match[3]
    
    fetch_wordnik_resource(msg, word, 'audio', {}) (err, res, body) ->
        pronunciations = JSON.parse(body)
      
        if pronunciations.length == 0
          msg.send "No pronounciation for \"#{word}\" found."
        else
          pronunciation = pronunciations[0]
          msg.send pronunciation.fileUrl

  robot.respond /spell(?: me)? (.*)/i, (msg) ->
    word = msg.match[1]

    fetch_wordnik_resource(msg, word, '', {includeSuggestions: 'true'}) (err, res, body) ->
      wordinfo = JSON.parse(body)
      if wordinfo.canonicalForm
        msg.send "\"#{word}\" is a word."
      else if not wordinfo.suggestions
        msg.send "No suggestions for \"#{word}\" found."
      else
        list = wordinfo.suggestions.join(', ')
        msg.send "Suggestions for \"#{word}\": #{list}"

fetch_wordnik_resource = (msg, word, resource, query, callback) ->
    
  msg.http("http://api.wordnik.com/v4/word.json/#{escape(word)}/#{escape(resource)}")
    .query(query)
    .header('api_key', 'f5e3c35b671307055200a03025f06a151b9d0de99fe8af739')
    .get(callback)
