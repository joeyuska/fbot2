# Description:
#   Simple JIRA
#
#
# Dependencies:
#   None
#
# Configuration:
#
# Commands:
#   @FWORK-1234 - Link to ticket
#
# Author:
#   Yahel Carmon
module.exports = (robot) ->
  robot.hear /\@([a-zA-Z]+\-[\d]+)/gi, (msg) ->
    results = msg.match
    console.log(results)
    for issue in results
      issue = issue.replace("@","").toUpperCase()
      console.log(issue)
      msg.send "#{issue}: https://jira.bluestatedigital.com/browse/#{issue}"