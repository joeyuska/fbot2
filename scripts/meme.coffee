#  Meme Generators.
#
# meme [yuno/troll/always/simply/notsure/penguin/things/success/expectations/live/problems/sparta/disappoint/badtime/theysaid/isbad/friday/crime/cookie/rent] - Generates meme Two sentences separated by | (pipe)
#
# doge (me)? so test, very parameter, much api request


module.exports = (robot) ->
    robot.respond /(doge)( me)? (.*)/i, (msg) ->
      suchArray = msg.match[3].split ','
      suchArray.push 'wow'
      for i in [suchArray.length-1..1]
        j = Math.floor Math.random() * (i + 1)
        [suchArray[i], suchArray[j]] = [suchArray[j], suchArray[i]]
      soEncode = suchArray.toString().replace(/\ /g, "").replace(/\,/g, "/")
      return msg.send "http://dogr.io/" + soEncode + ".png"
    
    robot.respond /meme.*/i, (msg) ->
        ms = msg.match[0].split(" ")
        ms.shift()
        ms.shift()
        type = ms.shift()
        lines = ms.join(" ").split("|")
        memes = {
           yuno : [2,166088],
           troll : [68, 269],
           always:  [76,2485],
           simply: [536349, 2706577],
           notsure: [305, 84688],
           penguin: [29, 983],
           things: [6013, 1121885],
           success: [121, 1031],
           facepalm: [1705, 213627],
           expectations: [111, 1436],
           live: [18391, 1151838],
           problems: [340895, 2055789],
           sparta: [623, 119210],
           disappoint: [22423,1167189],
           badtime: [825296,3786537],
           theysaid:[940069,4189879],
           isbad: [12270,1136171],
           friday: [1390,553193],
           crime: [1200661,5083105],
           cookie: [4397,1117992],
           crime: [1787718,7394568],
           rent: [998,203665]
        }
        if type is "list"
          list=""
          i=0
          for own key, value of memes
            list+=key
            list+= if i++%2 then "\n" else "\t\t"
          return msg.send list

        url = "http://version1.api.memegenerator.net/Instance_Create?username=epjiepjoq&password=32pj23pj&languageCode=en&generatorID=" + memes[type][0]+ "&imageID=" + memes[type][1] + "&text0="  + encodeURIComponent(lines[0]) 
        url += "&text1=" + encodeURIComponent(lines[1]) if lines[1]
        console.log("url", url)
        msg.http(url)
         .get() (err, res, body) ->
            result = JSON.parse(body).result;
            img = if result.instanceImageUrl.match(/^http/) then result.instanceImageUrl else "http://cdn.memegenerator.net/instances/400x/" + result.instanceID + ".jpg"
            msg.send img
# NOTE: Go to meme page and run this in console to get the meme codes:
# copy(JSON.stringify([+$("#generatorID").val() , +$("#imageID").val()]))
