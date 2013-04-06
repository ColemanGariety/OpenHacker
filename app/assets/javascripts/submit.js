var repos,
  contents,
  screenshot_jpg,
  collaborators = [],
  selected_repo,
  found_screenshot_jpg = false,
  found_description = false,
  found_commits = false,
  found_contributors = false

// Get repos
$.ajax({
  url: "https://api.github.com/user/repos?type=owner&sort=created&access_token=" + $("#user").attr("data-token"),
  type: "GET",
  dataType: "JSONP",
  success: function(data) {
    repos = data.data
    console.log(repos, "Repos")
    for (var i = 0; i < repos.length; i++) {
      $("#repos select").append("<option value=\"" + data.data[i].name + "\">" + data.data[i].name + "</option>")
    }
  }
})

$("#repos select").change(function() {
  if ($("#repos select").find(":selected").val() != "null") {
    $("#step-1").removeClass("focused")
    $("#step-2").addClass("focused")

    // Start check with screenshot
    $.ajax({
      url: "https://api.github.com/repos/" + $("#user").attr("data-username") + "/" + $("#repos select").find(":selected").val() + "/contents/?access_token=" + $("#user").attr("data-token"),
      type: "GET",
      dataType: "JSONP",
      success: function(data) {
        contents = data.data

        console.log(contents, "Contents")
        for (var i = 0; i < contents.length; i++) {
          if (data.data[i].name == "screenshot.jpg") {
            found_screenshot_jpg = data.data[i].url
          }
        }

        if (found_screenshot_jpg != false) {
          $("#screenshot_check").find(".mark").addClass("done")
        } else {
          $("#screenshot_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
        }

        setTimeout(function(){
          // Check for description
          for (var i = 0; i < repos.length; i++) {
            if (repos[i].name == $("#repos select").find(":selected").val()) {
              selected_repo = repos[i]

              if (repos[i].description != "") {
                found_description = repos[i].description
              }
            }
          }

          if (found_description != false) {
            $("#description_check").find(".mark").addClass("done")
          } else {
            $("#description_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
          }

          setTimeout(function(){
            // Check initial commit
            var opened_at = new Date($("#challenge").attr("data-opened-at"))
            var created_at = new Date(selected_repo.created_at)

            if (created_at >= opened_at) {
              found_commits = String(created_at)

              $("#commit_date_check").find(".mark").addClass("done")
            } else {
              $("#commit_date_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
            }

            setTimeout(function(){
              // Check contributors
              $.ajax({
                url: "https://api.github.com/repos/" + $("#user").attr("data-username") + "/" + $("#repos select").find(":selected").val() + "/collaborators",
                type: "GET",
                dataType: "JSONP",
                success: function(data) {
                  console.log(data.data, "Collaborators")

                  for (var i = 0; i < 3; i++) {
                    collaborators.push(data.data[i])
                  }

                  $("#contributor_check").find(".mark").addClass("done")
                }
              })
            },500)
          },500)

        },500)
      }
    })
  }
});