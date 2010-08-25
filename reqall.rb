require 'rubygems'
require 'feedzirra'
require 'task'

reqall_feed = ''

if reqall_feed == ''
  puts "please set your reqall_feed in reqall.rb"
  puts "please ensure your feed is http and not https"
  exit(1)
end

feed = Feedzirra::Feed.fetch_and_parse(reqall_feed)

feed.entries.each do |entry|
  Task.new(entry.title, "#{entry.summary} reqall:#{entry.entry_id}")
end


