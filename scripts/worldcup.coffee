# Description:
#   Show what's the score of the current world cup games
#
# Dependencies:
#   None
#
# Configuration:
#   None
# 
# Commands:
#   bsdbot what's the score?
#
# Author:
#   yahelc


module.exports = (robot) ->
  robot.respond /.*what.?s the score.*/i, (msg) ->
    msg.http('http://worldcup.sfg.io/matches/current').get() (err, res, body) ->
      
      if err
        msg.send "Error retrieving: #{err.message}"
      else
        try
          matches = JSON.parse(body)
          if not matches.length
            msg.send "No matches currently being played."
          for match in matches
            msg.send "#{match.home_team.country} #{match.home_team.goals} - #{match.away_team.country} #{match.away_team.goals}"

        catch ex
          x=0 
