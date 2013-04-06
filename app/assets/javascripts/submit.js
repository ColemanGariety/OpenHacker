params = {
  url: "https://api.github.com/user/repos?access_token=" + $("#user").attr("data-token"),
  type: "GET",
  dataType: "JSONP",
  success: function(data) {
    console.log(data)
    for (var i = 0; i < data.data.length; i++) {
      $("#repos").prepend("<li>" + data.data[i].name + "</li>")
    }
  }
}

$.ajax(params)