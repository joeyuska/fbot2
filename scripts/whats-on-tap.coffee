# Description:
#   Show what's on tap at BSD.
#
# Dependencies:
#   None
#
# Configuration:
#   None
# 
# Commands:
#   bsdbot what's on tap?
#
# Author:
#   yahelc


module.exports = (robot) ->
  robot.respond /.*what.?s on tap.*/i, (msg) ->
    msg.http('http://open.bluestatedigital.com/whatsontapatbsd.com/js/offices.json').get() (err, res, body) ->
      
      if err
        msg.send "Error retrieving: #{err.message}"
      else
        try
          offices = JSON.parse(body)
          
          for city, office of offices
            beers = []
            for beer in office.beers
              if beer.color != "00"
                beers.push beer.name
            verb = if beers.length > 1 then "are" else "is"
            beer_list = if beers.length then beers.join(' and ')  else "Nothing"
            msg.send "#{beer_list} #{verb} on tap in #{office.long_name}. "

        catch ex
          msg.send "Error: #{ex.message}"
          msg.send "JSON: #{body}"

#  robot.respond /beers/i, (msg) ->
#    msg.send "http://whatsontapatbsd.com/img/contact-sheet.jpg"
