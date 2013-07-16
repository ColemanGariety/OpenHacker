# Get repos
validateRepo = ->
  unless $("#repos select").find(":selected").val() is "null"
    $("#refresh-message").remove()
    $("#refresh-button").off "click"
    $("#collaborators_list").html ""
    $(".mark").html("&#10003;").attr "class", "mark"
    $("#step-2").removeClass "focused"
    $("#step-1").addClass "focused"
    found_screenshot_jpg = true
    found_description = false
    found_commits = false
    found_collaborators = []
    found_demo = false
    found_unique = true
    $("#step-1").removeClass "focused"
    $("#step-2").addClass "focused"
    
    # Start check with screenshot
    $.ajax
      url: "https://api.github.com/repos/" + $("#user").attr("data-username") + "/" + $("#repos select").find(":selected").val() + "/contents/?access_token=" + $("#user").attr("data-token")
      type: "GET"
      dataType: "JSONP"
      success: (data) ->
        
        $("nav").css "-webkit-backface-visibility", "hidden" # Fix WebKit flickering
        
        contents = data.data
        console.log contents, "Contents"
        i = 0

        while i < contents.length
          found_screenshot_jpg = data.data[i].html_url.replace("https://github.com/", "https://raw.github.com/").replace("/blob/", "/")  if data.data[i].name is "screenshot.jpg"
          i++
        unless found_screenshot_jpg is false
          $("#screenshot_check").find(".mark").addClass "done"
        else
          $("#screenshot_check").find(".mark").html("&#10006;").addClass("red").addClass "done"
        setTimeout (->
          
          # Check for description
          i = 0

          while i < repos.length
            if repos[i].name is $("#repos select").find(":selected").val()
              selected_repo = repos[i]
              found_description = repos[i].description  unless repos[i].description is ""
            i++
          unless found_description is false
            $("#description_check").find(".mark").addClass "done"
          else
            $("#description_check").find(".mark").html("&#10006;").addClass("red").addClass "done"
          setTimeout (->
            
            # Check initial commit
            opened_at = new Date($("h1").attr("data-opened-at"))
            created_at = new Date(selected_repo.created_at)
            console.log opened_at + ":" + created_at
            if created_at >= opened_at
              found_commits = String(created_at)
              $("#commit_date_check").find(".mark").addClass "done"
            else
              $("#commit_date_check").find(".mark").html("&#10006;").addClass("red").addClass "done"
            setTimeout (->
              
              # Check contributors
              $.ajax
                url: "https://api.github.com/repos/" + $("#user").attr("data-username") + "/" + $("#repos select").find(":selected").val() + "/collaborators?access_token=" + $("#user").attr("data-token")
                type: "GET"
                dataType: "JSONP"
                success: (data) ->
                  console.log data.data, "Collaborators"
                  i = 0
                  while found_collaborators.length <= 3 and data.data[i] isnt `undefined`
                    found_collaborators.push data.data[i].login
                    i++
                  $("#contributor_check").find(".mark").addClass "done"
                  setTimeout (->
                    
                    # Check demo URL
                    if selected_repo.homepage?
                      found_demo = selected_repo.homepage
                      $("#demo_check").find(".mark").addClass "done"
                    else
                      $("#demo_check").find(".mark").html("&#10006;").addClass("red").addClass "done"
                    setTimeout (->
                      
                      # Check uniqueness
                      $.ajax
                        url: "http://" + document.location.hostname + "/entries.json"
                        success: (data) ->
                          console.log data, "Entries"
                          i = 0

                          while i < data.length
                            found_unique = false if data[i].github_repo_id is selected_repo.id
                            i++
                          if found_unique is true
                            $("#uniqueness_check").find(".mark").addClass "done"
                          else
                            $("#uniqueness_check").find(".mark").html("&#10006;").addClass("red").addClass "done"
                          
                          $("#step-2 button").removeAttr "disabled" # Enable buttons

                          if found_screenshot_jpg isnt false and found_description isnt false and found_commits isnt false and found_collaborators isnt false and found_demo isnt false and found_unique is true
                            $("#step-2").removeClass "focused"
                            $("#step-3").addClass "focused"
                            $("#step-2 button").attr "disabled", "true" # Disable buttons
                            $('#step-3 input[type="submit"], #step-3 button').removeAttr "disabled"
                            $("#repo-title").html selected_repo.name
                            $("#repo-desc").html found_description
                            $("#repo-url").html "<a target=\"_blank\" href=\"" + found_demo + "\">" + found_demo + "</a>"
                            $("#preview .image-wrap").html "<img src=\"" + found_screenshot_jpg + "\">"
                            $("#entry_title").val selected_repo.name
                            $("#entry_description").val found_description
                            $("#entry_repo_url").val selected_repo.html_url
                            $("#entry_thumb_url").val found_screenshot_jpg
                            $("#entry_demo_url").val found_demo
                            $("#entry_github_repo_id").val selected_repo.id

                          $("#refresh-button").click ->
                            $("#step-2 button").attr "disabled", "true" # Disable buttons
                            $("#refresh-message").remove()
                            $("#refresh-button").off "click"
                            $("#collaborators_list").html ""
                            $(".mark").html("&#10003;").attr "class", "mark"
                            found_screenshot_jpg = false
                            found_description = false
                            found_commits = false
                            found_collaborators = []
                            found_demo = false
                            found_unique = true
                            validateRepo()
                          
                          $(".change-repo-button").click ->
                            $('button, input[type="submit"]').attr "disabled", "true" # Disable buttons
                            $("#repos select").val "null"
                            $("#refresh-message").remove()
                            $("#refresh-button").off "click"
                            $("#collaborators_list").html ""
                            $(".mark").html("&#10003;").attr "class", "mark"
                            $("#step-2").removeClass "focused"
                            $("#step-3").removeClass "focused"
                            $("#step-1").addClass "focused"
                            found_screenshot_jpg = false
                            found_description = false
                            found_commits = false
                            found_collaborators = []
                            found_demo = false
                            found_unique = true
                    ), 250
                  ), 250

            ), 250
          ), 250
        ), 250

repos = undefined
contents = undefined
screenshot_jpg = undefined
selected_repo = undefined
found_screenshot_jpg = false
found_description = false
found_commits = false
found_collaborators = []
found_demo = false
found_unique = true
$.ajax
  url: "https://api.github.com/user/repos?type=owner&sort=created&access_token=" + $("#user").attr("data-token")
  type: "GET"
  dataType: "JSONP"
  success: (data) ->
    repos = data.data
    console.log repos, "Repos"
    i = 0

    while i < repos.length
      $("#repos select").append "<option value=\"" + data.data[i].name + "\">" + data.data[i].name + "</option>"
      i++
    $("#repos select").removeAttr "disabled"

$ ->
  $("#repos select").change validateRepo
