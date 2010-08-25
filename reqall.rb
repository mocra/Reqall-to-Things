require 'rubygems'
require 'feedzirra'
require 'task'

reqall_feed = ''

reqall_feed = ARGV.first unless ARGV.first.nil?

if reqall_feed == ''
  puts "We need to know where your reqall feed is."
  puts "You can either hardcode it in the reqall.rb file"
  puts "or simple pass it in as the first paramater: ruby requall http://myreqallfeed.com"
  exit(1)
end

# Read the last run time, and record the time now

if File.exists?('reqall_to_things.dat')
  File.open('reqall_to_things.dat', 'r') { |f| @last_run_time = Time.parse(f.read) }
end
File.open('reqall_to_things.dat', 'w') { |f| f.write(Time.now) }

# Grab the feed and parse it, adding new entries to the Things app
feed = Feedzirra::Feed.fetch_and_parse(reqall_feed)
feed.entries.each do |entry|
  
  if defined?(@last_run_time)
    if entry.published.utc > @last_run_time.utc
      puts "Adding #{entry.title} - #{entry.summary} to Things" 
      Task.new(entry.title, "#{entry.summary} reqall:#{entry.entry_id}")
    end
  else
    puts "Adding #{entry.title} - #{entry.summary} to Things" 
    Task.new(entry.title, "#{entry.summary} reqall:#{entry.entry_id}")
  end
end
