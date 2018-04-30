#!/usr/bin/env ruby

require_relative "../common/tools.rb"

files = find_files "project.pbxproj"

project_file = files.find {|name| name.include? "QuickSwift/QuickSwift.xcodeproj" }

puts "Project file is #{project_file}"

project_swift_files = []
content = File.open(project_file, 'r'){|f| f.read}
content.scan(/[A-Z][A-Za-z0-9]+.swift/) do |match|  
  project_swift_files << match
end

project_swift_files.sort!
project_swift_files.uniq!

find_swift_files = find_files("*.swift").select{|e| e.include? "QuickSwift/QuickSwift"}.map { |e| e.split("/").last }.sort.uniq

unused_files = find_swift_files - project_swift_files

puts "======Unused files======"
puts unused_files
puts "========================"

unused_files.each do |file|
  target_file = find_files(file).first
  puts "Deleting #{target_file}..."
  %x[ rm #{target_file} ]

end

puts "Done"
