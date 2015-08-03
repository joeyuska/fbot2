# Script that generates a random number for you to use for rolling D&D dice.
# or you know
# random number generation
#
#
#
# but mostly for D&D
#
module.exports = (robot) ->
  robot.respond /roll dice?(?: (\d+))?$/i, (msg) ->
    msg.send rollDice(msg.match[1])

# eventually i'd like to figure out how to get the number they type in that optional capturing group and pass it to the rollDice() function. right now it only works with a d20

rollDice = (die)->
  d = die || 20;
  result = Math.floor(Math.random()*d) + 1
  if result == 20 && d == 20
  	result = "20! CRITICAL HIT!"
  if result == 1 && d == 20
  	result = "1! Oh no! Critical faaaaaiiiilllluuuureeeeeeee"
  return "You rolled a d" + d + " and got a " + result