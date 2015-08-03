# Description:
#   returns images from /r/babygoats
#
# Commands:
#   baby goat bomb - Display the images from /r/babygoats
#
# Author:
#   maxhallinan 


module.exports = (robot) ->
  robot.respond /baby goat bomb( (\d+))?/i, (msg) ->
    
    msg.http("http://www.reddit.com/r/babygoats.json")
    .get() (err, res, body) ->
      try
        result = JSON.parse(body)
        urls = [ ]
        for child in result.data.children
          if child.data.domain is "i.imgur.com" 
            urls.push(child.data.url)

        shuffleArray = (array) ->
          i = array.length - 1

          while i > 0
            j = Math.floor(Math.random() * (i + 1))
            temp = array[i]
            array[i] = array[j]
            array[j] = temp
            i--
          array

        urls = shuffleArray(urls)

        for i in [0..urls.length - 1] by 1
          msg.send urls[i]

      catch error 
        msg.send "All the baby goats were eaten by a troll underneath a bridge!"
