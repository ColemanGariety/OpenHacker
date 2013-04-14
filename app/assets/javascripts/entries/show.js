$(".star-wrapper").click(function(){
  $(".voted").removeClass("voted")
  $(this).addClass("voted")
})

$(".star-wrapper").hover(function(){
  $(this).prevAll().addClass("cancelled")
}, function(){
  $(this).prevAll().removeClass("cancelled")
})