# Jonas!
#
# Jonas me- A random baby Jonas of specific type

jonas = ["http://feminspire.com/wp-content/uploads/2014/10/nick-jonas-jealous-video-thatgrapejuice.jpg",
"http://mixmatters.com/uploads/video/image/6127/Nick-Jonas---Jealous-video.jpg",
"http://poisonparadise.com/wp-content/uploads/2014/10/Nick-Jonas-Flaunt4.jpg",
"http://www.billboard.com/files/styles/promo_650/public/media/nick-jonas-flaunt-mag-cover-2014-billboard-650.jpg?itok=Lt37Z9AI",
"http://www.shineon-media.com/wp-content/gallery/nick-jonas-cosmo-oct-2014/nickjonas-cosmooct-001.jpg",
"https://files.ctctcdn.com/aacc9aa7001/de841f2f-a9cf-443d-80f8-4260e51f720f.png",
"http://haircutsformen.org/buzzblog/wp-content/gallery/nick-jonas-haircuts/nick-jonas-haircut-3.jpg",
"http://www1.pictures.zimbio.com/gi/Nick+Jonas+0bGVw7c9fbjm.jpg"
]

module.exports = (robot) ->
  robot.respond /(jonas me)/i, (msg) ->
    msg.send msg.random jonas

  robot.respond /jonas bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    if count > 5
      count = 5
    clone = jonas.slice(0)
    bomb = new Array
    i = 0
    while i < count
      index = Math.floor(Math.random() * clone.length)
      bomb.push clone.splice index, 1
      i++
    msg.send pic for pic in bomb