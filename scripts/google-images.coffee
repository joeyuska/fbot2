# A way to interact with the Google Images API.
#
# image me <query>    - The Original. Queries Google Images for <query> and
#                       returns a random top result.
# animate me <query>  - Searches for a gif for your term using giphy
# mustache me <url>   - Adds a mustache to the specified URL.
# mustache me <query> - Searches Google Images for the specified query and
#                       mustaches it.
module.exports = (robot) ->
  robot.respond /(image|img)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /animate me (.*)/i, (msg) ->
    msg.http("http://api.giphy.com/v1/gifs/search")
    .query(q : msg.match[1],"api_key":"dc6zaTOxFJmzC", limit: 5)
    .get() (err, res, body) ->
      data = JSON.parse(body)
      if data.data and data.data.length
        image = msg.random data.data
        msg.send image.images.original.url

  robot.respond /(?:\(hipster\)|(?:mo?u)?sta(?:s|c)he?)(?: me)? (.*)/i, (msg) ->
    imagery = msg.match[1]
    mustachify = "http://mustachify.me/?src="
    if imagery.match /^https?:\/\//i
      msg.send "#{mustachify}#{imagery}"
    else
      imageMe msg, imagery, (url) ->
        msg.send "#{mustachify}#{url}"

imageMe = (msg, query, cb) ->
  ips = ["205.232.183.194","71.183.93.130","50.241.93.177","67.151.108.225", "77.89.161.42"]
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(v: "1.0", rsz: '8', q: query, userip:  msg.random ips )
    .get() (err, res, body) ->
      images = JSON.parse(body)
      if images and images.responseData and images.responseData.results
        images = images.responseData.results
        image  = msg.random images
        cb "#{image.unescapedUrl}#.png"
      else
        cb "#googleapifail"

