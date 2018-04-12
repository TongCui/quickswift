#!/usr/bin/env ruby

require_relative "../common/tools.rb"

files = find_files "*.storyboard"
files.reject! {|x| x.include? "Carthage"}

files.each do |storyboard|
  puts "=======Checking file #{storyboard}========="
  content =  File.open(storyboard, 'r') {|f| f.read}
  new_content = content.gsub(/<viewController [^>]+customClass="([a-zA-Z]+ViewController)"/) do |match|  
    vc_name = $1
    if match =~ /storyboardIdentifier="([^"]+)"/
      if $1 == vc_name
        puts "Ignore #{vc_name}"
        match
      else
        puts "Wrong #{vc_name}"
        match.gsub("storyboardIdentifier=\"#{$1}\"", "storyboardIdentifier=\"#{vc_name}\"")
      end
    else
      puts "Match #{vc_name}"
      match.insert("<viewController ".size, "storyboardIdentifier=\"#{vc_name}\" ")
    end
  end
  
  File.open(storyboard, 'w') {|f| f.write new_content}
  
end
