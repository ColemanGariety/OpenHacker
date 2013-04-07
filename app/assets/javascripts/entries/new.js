var repos,
  contents,
  screenshot_jpg,
  selected_repo,
  found_screenshot_jpg = false,
  found_description = false,
  found_commits = false,
  found_collaborators = [],
  found_demo = false,
  found_unique = true

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

    $("#repos select").removeAttr("disabled")
  }
})

function validateRepo() {
  if ($("#repos select").find(":selected").val() != "null") {

    $("#refresh-message").remove()
    $("#refresh-button").off("click")
    $("#collaborators_list").html("")
    $(".mark").html("&#10003;").attr("class","mark")
    $("#step-2").removeClass("focused")
    $("#step-1").addClass("focused")

    var found_screenshot_jpg = false,
      found_description = false,
      found_commits = false,
      found_collaborators = [],
      found_demo = false,
      found_unique = true

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
            found_screenshot_jpg = data.data[i].html_url.replace("https://github.com/","https://raw.github.com/").replace("/blob/","/")
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

            console.log(opened_at + ":" + created_at)

            if (created_at >= opened_at) {
              found_commits = String(created_at)

              $("#commit_date_check").find(".mark").addClass("done")
            } else {
              $("#commit_date_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
            }

            setTimeout(function(){
              // Check contributors
              $.ajax({
                url: "https://api.github.com/repos/" + $("#user").attr("data-username") + "/" + $("#repos select").find(":selected").val() + "/collaborators?access_token=" + $("#user").attr("data-token"),
                type: "GET",
                dataType: "JSONP",
                success: function(data) {
                  console.log(data.data, "Collaborators")

                  var i = 0
                  while (found_collaborators.length <= 3 && data.data[i] != undefined) {
                    found_collaborators.push(data.data[i].login)
                    $("#collaborators_list").append("<li>" + data.data[i].login + "</li>")
                    i++
                  }

                  $("#contributor_check").find(".mark").addClass("done")

                  setTimeout(function(){
                    // Check demo URL
                    if (selected_repo.homepage != null) {
                      found_demo = selected_repo.homepage

                      $("#demo_check").find(".mark").addClass("done")
                    } else {
                      $("#demo_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
                    }

                    setTimeout(function(){
                      // Check uniqueness
                      $.ajax({
                        url: "http://" + document.location.hostname + "/entries.json",
                        success: function(data) {
                          console.log(data, "Entries")

                          for (var i = 0; i < data.length; i++) {
                            if (data[i].github_repo_id == selected_repo.id) {
                              found_unique = false
                            }
                          }

                          if (found_unique == true) {
                            $("#uniqueness_check").find(".mark").addClass("done")
                          } else {
                            $("#uniqueness_check").find(".mark").html("&#10006;").addClass("red").addClass("done")
                          }

                          if (found_screenshot_jpg != false && found_description != false && found_commits != false && found_collaborators != false && found_demo != false && found_unique == true) {
                            $("#step-2").removeClass("focused")
                            $("#step-3").addClass("focused")
                            $("#repo-title").html(selected_repo.name)
                            $("#repo-desc").html(found_description)
                            $("#repo-url").html("<a target=\"_blank\" href=\"" + found_demo + "\">" + found_demo + "</a>")
                            $("#preview .image-wrap").html("<img src=\"" + found_screenshot_jpg + "\">")
                            $("#entry_title").val(selected_repo.name)
                            $("#entry_description").val(found_description)
                            $("#entry_repo_url").val(selected_repo.html_url)
                            $("#entry_thumb_url").val(found_screenshot_jpg)
                            $("#entry_demo_url").val(found_demo)
                            $("#entry_github_repo_id").val(selected_repo.id)
                          } else {
                            $("#check").append("<li id=\"refresh-message\"><br><i><span>Fix the problems and <a href='javascript:;' id='refresh-button'>refresh</a>, or <a href='javascript:;' id='change-repo-button'>pick a different repo</a>.</span></i></li>")

                            $("#refresh-button").click(function(){
                              $("#refresh-message").remove()
                              $("#refresh-button").off("click")
                              $("#collaborators_list").html("")
                              $(".mark").html("&#10003;").attr("class","mark")

                              var found_screenshot_jpg = false,
                                found_description = false,
                                found_commits = false,
                                found_collaborators = [],
                                found_demo = false,
                                found_unique = true

                              validateRepo()
                            })

                            $("#change-repo-button").click(function(){
                              $("#repos select").val('Pick one...')
                              $("#refresh-message").remove()
                              $("#refresh-button").off("click")
                              $("#collaborators_list").html("")
                              $(".mark").html("&#10003;").attr("class","mark")
                              $("#step-2").removeClass("focused")
                              $("#step-1").addClass("focused")

                              var found_screenshot_jpg = false,
                                found_description = false,
                                found_commits = false,
                                found_collaborators = [],
                                found_demo = false,
                                found_unique = true
                            })
                          }
                        }
                      })
                    }, 250)
                  }, 250)
                }
              })
            }, 250)
          }, 250)

        }, 250)
      }
    })
  }
}

$(function(){

  $("#repos select").change(validateRepo);
})