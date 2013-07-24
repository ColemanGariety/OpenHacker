
# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require countdown

if location.hash == "#tweet"
  $("#overlay").addClass("active")

# Preload images
preload = ['/assets/github.png', '/assets/github@2x.png', '/assets/github_hover.png', '/assets/github_hover@2x.png', '/assets/github_active.png', '/assets/github_active@2x.png']
images = []
i = 0
while i < preload.length
  images[i] = new Image()
  images[i].src = preload[i]
  i++

# Update user data
if $("#user").attr("data-username")
  setTimeout (->
    $.ajax
      url: "https://api.github.com/user?access_token=" + $("#user").attr("data-token")
      type: "GET"
      dataType: "JSONP"
      success: (data) ->
        # console.log data
        $.ajax
          url: "http://" + document.location.hostname + "/auth/github/update"
          type: "POST"
          data:
            auth: data

          success: (data) ->
            console.log data
  ), 10000

doTime = ->
  now = new Date()
  daysToAdd = 8 - (new Date()).getDay()
  sunday = new Date()
  sunday.setDate(now.getDate() + daysToAdd)
  sunday.setHours(0)
  sunday.setMinutes(0)
  sunday.setSeconds(0)
  sunday.setMilliseconds(0)
  
  $(".ticker").html(countdown(new Date(), sunday).toString())

$("#ex").click ->
  $("#overlay").removeClass("active")

# Ticker
setInterval(doTime, 1000)
doTime()

# Sidebar
$("html, body").add(document).scroll(->
  if $(document).scrollTop() > 50
    $("aside").addClass("active")
  else
    $("aside").removeClass("active")
)