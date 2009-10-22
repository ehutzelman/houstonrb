task :cron => :environment do
  puts "Updating meetings from calendar..."
  Meeting.refresh_from_calendar
  puts "done."
end