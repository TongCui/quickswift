#!/usr/bin/env ruby

# ARGV.each do|a|
#   puts "Argument: #{a}"
# end

add = true
unless ARGV.empty?
  add = ARGV[0] == "add"
end

puts add

info_plist_path = File.expand_path("#{$0}/../../../Example/Example/Info.plist", Dir.pwd)

ending = <<EOM
</dict>
</plist>
EOM

ats_settings = <<EOM
\t<key>NSAppTransportSecurity</key>
\t<dict>
\t\t<key>NSAllowsArbitraryLoads</key>
\t\t<true/>
\t</dict>
EOM

line = File.open(info_plist_path, "r") {|f| f.read}
if add
  unless line.include? ats_settings
    line.sub!(ending, "#{ats_settings}#{ending}")
    File.open(info_plist_path, "w") {|f| f.write line}
    puts ">> Done"
  else
    puts ">> Already added, check again"
    puts ats_settings
  end
else
  if line.include? ats_settings
    line.sub!(ats_settings, "")
    File.open(info_plist_path, "w") {|f| f.write line}
    puts ">> Done"
  else
    puts ">> Already removed, check again"
    puts ats_settings
  end
end

