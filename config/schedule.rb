set :output, "#{path}/log/cron.log"

every :wednesday, :at => '11:44pm' do # Use any day of the week or :weekend, :weekday
  runner "Challenge.cron", :environment => 'development' 
end