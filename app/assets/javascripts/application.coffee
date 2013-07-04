
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
  ), 3000