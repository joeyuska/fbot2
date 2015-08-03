# Otters are way cuter than pugs.
# Let's see more of them.
#
# otter me - Get an otter.
# otter bomb N - N MOAR otters!

module.exports = (robot) ->

    robot.respond /(.*)otter me/i, (msg) ->
        msg.http("http://www.ottersfor.me/api/v1/random")
            .get() (err, res, body) ->
                msg.send JSON.parse(body).otter

    robot.respond /otter bomb( (\d+))?/i, (msg) ->
        count = msg.match[2] || 5
        if count > 10
            count = 10
        msg.http("http://www.ottersfor.me/api/v1/bomb/" + count)
        .get() (err, res, body) ->
            msg.send otter for otter in JSON.parse(body).otter_payload
          
    robot.respond /how many otters are there/i, (msg) ->
        msg.http("http://www.ottersfor.me/api/v1/count")
            .get() (err, res, body) ->
                msg.send "There are #{JSON.parse(body).otter_count} otters."
