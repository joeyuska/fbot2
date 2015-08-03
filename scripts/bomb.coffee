# A way to interact with the Google Images API.
#
# bomb me <query>    - The Original. Queries Google Images for <query> and
#                       returns a random top result.
# bomb animate me <query>  - Searches for a gif for your term using giphy
#
module.exports = (robot) ->
  robot.respond /bomb me (.*)( (\d+))?/i, (msg) ->
    imageMe msg, msg.match[1], 5, (url) ->
      msg.send item for item in url

  robot.respond /bomb animate me (.*)( (\d+))?/i, (msg) ->
    msg.http("http://api.giphy.com/v1/gifs/search")
    count = 5
    msg.send msg.match[1]
    .query(q : msg.match[1],"api_key":"dc6zaTOxFJmzC", limit: count)
    .get() (err, res, body) ->
      data = JSON.parse(body)
      if data.data and data.data.length
        while i < count
          index = Math.floor(Math.random() * data.data.length)
          image.push data.data.splice index 1
          i++

        msg.send x.images.original.url for x in image


imageMe = (msg, query, number, cb) ->
  ips = ["205.232.183.194","71.183.93.130","50.241.93.177","67.151.108.225", "77.89.161.42"]
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query, userip:  msg.random ips )
    .get() (err, res, body) ->
      images = JSON.parse(body)
      if images and images.responseData and images.responseData.results
        images = images.responseData.results
        while j < number
          place = Math.floor(Math.random() * images.length)
          image.push images.splice(place, 1).unescapeUrl
          j++
        cb image
      else
        cb "#googleapifail"