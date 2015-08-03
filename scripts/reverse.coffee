#Reversegif
#
# reverse me - Reverse a gif
QS = require "querystring"
module.exports = (robot) ->

  robot.respond /(reverse)( me)? (.*)/i, (msg) ->
    msg.http("http://www.smileygenerator.us/gif_reverse/")
      .header("Content-Type", "application/x-www-form-urlencoded")
      .header({"Referer": "http://www.smileygenerator.us/gif_reverse/","User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.40 Safari/537.17"})
      .post(QS.stringify({"ani": msg.match[3] + "#.gif" , "go":"true"})) (err, res, body) ->
           smiley = "http://www.smileygenerator.us/gif_reverse/"+body.match(/.*(cache.*gif).*/).pop()
           msg.http("https://api.imgur.com/3/image" ).header("Authorization","Client-ID d9944b82f2bc634").query({"_method":"post","image": smiley, type: "URL"}).get() (err, res, body) ->
               data = JSON.parse(body).data
               msg.send data.link or smiley


