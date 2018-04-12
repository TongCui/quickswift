#!/usr/bin/env ruby

def to_camel_name(name)
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

def project_base_folder
  File.expand_path("#{$0}/../../../", Dir.pwd)
end

def find_files(pattern)
  res = %x[ find #{project_base_folder} -name "#{pattern}"]
  res.split
end
