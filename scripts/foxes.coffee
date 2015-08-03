# Foxes!
#
# fox me- A random baby fox

foxes = ["http://images.fineartamerica.com/images-medium-large-5/fox-cubs-cuddle-william-jobes.jpg",
"http://37.media.tumblr.com/tumblr_m6qw3jp11q1rwf4lko1_500.jpg",
"http://www.canadiannaturephotographer.com/digitalfilters/foxparty.jpg",
"http://cdn.cutestpaw.com/wp-content/uploads/2013/02/l-baby-foxes.jpg",
"http://25.media.tumblr.com/a257195173436c7ec7cee9de04fa1eb7/tumblr_mqsdjtcxMJ1sb3foxo1_500.jpg",
"http://i.imgur.com/5apD21I.jpg",
"http://media-cache-cd0.pinimg.com/236x/fc/cb/57/fccb57272766d49b8e9837baf35e65e8.jpg",
"http://holycuteness.com/wp-content/uploads/2011/09/Screenshot-16-9-2011-22_45_47.png",
"https://s3.amazonaws.com/assets.rbl.ms/180293/210x.jpg",
"http://i.imgur.com/3puZKb5.gif"
]

module.exports = (robot) ->
  robot.respond /(fox me)/i, (msg) ->
    msg.send msg.random foxes
