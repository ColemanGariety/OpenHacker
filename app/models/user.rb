class User < ActiveRecord::Base
  def self.from_omniauth(auth)
    find_by_github_uid(auth["uid"]) || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.github_uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.full_name = auth["info"]["name"]
      user.gravatar_id = auth["extra"]["raw_info"]["gravatar_id"]
      user.blog_url = auth["extra"]["raw_info"]["blog"]
      user.company = auth["extra"]["raw_info"]["company"]
      user.location = auth["extra"]["raw_info"]["location"]
      user.hireable = auth["extra"]["raw_info"]["hireable"]
      user.bio = auth["extra"]["raw_info"]["bio"]
    end
  end

  def to_param
    username
  end
end
