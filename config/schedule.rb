every :sunday, :at => '11:59pm' do # Use any day of the week or :weekend, :weekday
  runner "Challenge.cron"
end