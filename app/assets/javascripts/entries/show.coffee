$(".star-wrapper").click ->
  $(".voted").removeClass "voted"
  $(this).addClass "voted"

$(".star-wrapper").hover (->
  $(this).prevAll().addClass "cancelled"
), ->
  $(this).prevAll().removeClass "cancelled"

$("#source-link").click (e) ->
  e.preventDefault()
  
  $("#source").toggleClass("active")
  
  if $(this).children("div").html() == "View Source"
    $(this).children("div").html("View Demo")
  else
    $(this).children("div").html("View Source")