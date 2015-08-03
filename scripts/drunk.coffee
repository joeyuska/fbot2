# Go home, you're drunk
#
# go home, you're drunk - Send drunk bsdbot home


sad = [
    "http://24.media.tumblr.com/tumblr_ltqip9g9Jh1qbycn1o2_250.gif",
    "https://warosu.org/data/cgl/img/0068/20/1367890348857.gif",
    "http://stream1.gifsoup.com/webroot/animatedgifs/1066235_o.gif",
    "http://forums.wpcentral.com/attachments/windows-apps-games/57408d1392761727t-tumblr_lozfa3p4th1qjutzao4_400.gif"
]

module.exports = (robot) ->
  robot.respond /.go home.? you.?re drunk.*/i, (msg) ->
    msg.send msg.random sad
