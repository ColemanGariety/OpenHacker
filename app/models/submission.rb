class Submission < ActiveRecord::Base
  attr_accessible :challenge, :description, :github_url, :name, :user_id
end
