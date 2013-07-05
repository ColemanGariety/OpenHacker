set :output, "#{path}/log/cron.log"

every :monday, :at => '12:00am' do
  runner "Challenge.weekly", :environment => 'development'
end