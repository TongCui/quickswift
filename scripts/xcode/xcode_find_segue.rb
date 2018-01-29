#!/usr/bin/env ruby

unless ARGV.empty?
  add = ARGV[0] == "add"
end

basic_folder = File.expand_path("#{$0}/../../../", Dir.pwd)
puts basic_folder

target_lines = %x[ find #{basic_folder} -name "*.storyboard" -exec grep segue {} \\; ]

segue_ids = []

target_lines.split("\n").each do |line|
  if line[/identifier="([^"]+)"/]
    segue_ids << $1
  end
end

def toCamelName(name)
  res = []
  excepts = ["vc", "url", "http"]
  name.split("_").each_with_index do |value, idx|
    if idx == 0
      res.push value
    else
      if excepts.include? value
        res.push value.upcase
      else
        res.push value.capitalize
      end
    end
  end
  res.join("")
end

content = segue_ids.map {|x| "  case #{toCamelName(x)} = \"#{x}\""}.join("\n")
template = <<EOF

enum SegueIds: String {
#{content}
}

EOF

puts template