class User < ActiveRecord::Base
  belongs_to :challenge

  has_many :votes
  has_many :challenges
  has_many :entries

  def self.from_omniauth(auth)
    find_by_github_uid(auth["uid"]) || create_from_omniauth(auth)
  end

  def self.update_omniauth(auth)
    user = find_by_github_uid(auth["data"]["id"])
    user.username = auth["data"]["login"]
    user.email = auth["data"]["email"]
    user.full_name = auth["data"]["name"]
    user.gravatar_id = auth["data"]["gravatar_id"]
    user.blog_url = auth["data"]["blog"]
    user.company = auth["data"]["company"]
    user.location = auth["data"]["location"]
    user.hireable = auth["data"]["hireable"] || 0
    user.bio = auth["data"]["bio"]
    user.save
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.github_uid = auth["uid"]
      user.github_token = auth["credentials"]["token"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.full_name = auth["info"]["name"] || user.username
      user.gravatar_id = auth["extra"]["raw_info"]["gravatar_id"]
      user.blog_url = auth["extra"]["raw_info"]["blog"]
      user.company = auth["extra"]["raw_info"]["company"]
      user.location = auth["extra"]["raw_info"]["location"]
      user.hireable = auth["extra"]["raw_info"]["hireable"] || 0
      user.bio = auth["extra"]["raw_info"]["bio"]
    end
  end
  
  def first_name
    self.full_name ? self.full_name.split(" ").first : self.username
  end

  def to_param
    username.to_s
  end
end