# BSDbot finds the soda!
# bsdbot <where did the soda go> or bsdbot <where did the soda go?>
# returns a random gif from r/wheredidthesodago

module.exports = (robot) ->
  robot.respond /where did the soda go[?]?/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('http://www.reddit.com/r/wheredidthesodago.json')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.data.children.count <= 0
          msg.send "I can't find the soda!"
          return
        
        urls = [ ]
        for child in result.data.children
          if /.gif/i.test(child.data.url)
            urls.push(child.data.url)
          
        rnd = Math.floor(Math.random()*urls.length)
        #hipchat don't want none of that .gifv business
        msg.send urls[rnd].replace('.gifv', '.gif')
