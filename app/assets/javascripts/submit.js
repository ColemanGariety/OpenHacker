params = {
  url: "https://api.github.com/users/" + $("#user").attr("data-username") + "/repos",
  type: "GET",
  dataType: "JSONP",
  success: function(data) {
    for (var i = 0; i < data.data.length; i++) {
      $("#repos").prepend("<li>" + data.data[i].name + "</li>")
    }
  }
}

$.ajax(params)