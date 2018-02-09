#!/usr/bin/env ruby

commands = {}
commands[:swift_debug_view] = 'po <view>.value(forKey: "recursiveDescription")!'

puts "Commands"
commands.each do |k, v|
  puts "#{k}  ->  #{v}"
end