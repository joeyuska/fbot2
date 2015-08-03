# No one messes around with the Chuck Norris Joke API.
#
# chucknorris me <query> - Fetches a Chuck Norris style joke.
#                      
module.exports = (robot) ->
  robot.respond /(chuck(\w?norris)?)( me)? (.*)/i, (msg) ->
    query = msg.match[4].split " "
    msg.http("http://api.icndb.com/jokes/random")
      .query({
        lastName: query.pop()
        firstName: query.join " "
      })
      .get() (err, res, body) ->
        jokes = JSON.parse(body)
        msg.send jokes.value.joke