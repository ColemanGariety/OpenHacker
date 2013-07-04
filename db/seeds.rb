# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if ENV['RAILS_ENV'] == 'development'
	User.create()

	user = User.first
	puts 'created a blank user'
	(1..5).each do |n|
		Challenge.create(title: "Challenge #{n}", description: "I am challenge #{n}", user_id: user.id, prize: "#{n + 1} unicorns", status: n - 1)
		puts "created challenge #{n}"
	end
	Challenge.last(4).each do |challenge|
		Entry.create(challenge_id: challenge.id, github_repo_id: "1234#{challenge.id}", user_id: user.id)
		puts "created entry for challenge #{challenge.id}"
	end
puts 'database seeded!'
end