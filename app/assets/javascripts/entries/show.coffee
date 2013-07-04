$(".star-wrapper").click ->
  $(".voted").removeClass "voted"
  $(this).addClass "voted"

$(".star-wrapper").hover (->
  $(this).prevAll().addClass "cancelled"
), ->
  $(this).prevAll().removeClass "cancelled"