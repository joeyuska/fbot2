# Jandocs!
#
# jandoc me - A randomly selected jandoc from placejandoc
# jandoc bomb me <number> - Many many jandocs!

module.exports = (robot) ->

  robot.respond /(.*)jandoc me/i, (msg) ->
      msg.http("http://randoc.sandbox-gschaffzin.dev.bsd.net/")
          .get() (err, res, body) ->
              msg.send body

  robot.respond /jandoc bomb(?: me)?( \d+)?$/i, (msg) ->
    jandocs = msg.match[1] || 5
    (msg.http("http://randoc.sandbox-gschaffzin.dev.bsd.net/")
        .get() (err, res, body) ->
            msg.send body) for i in [1..jandocs]
