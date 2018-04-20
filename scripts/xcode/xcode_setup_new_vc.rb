#!/usr/bin/env ruby

require_relative "../common/tools.rb"

unless ARGV.empty?
  name = ARGV[0]
else
  puts "Please enter a ViewController"
  exit!
end


files = find_files "#{name}.swift"
puts files

unless files.count == 1
  puts "Search Failed, please check the ViewController name again"
  exit!
end

file_name = files.first

lines = File.open(file_name, 'r'){|f| f.readlines}
line = lines.find_index{|x| !(x.start_with? "//") }

template = <<EOF


import QuickSwift
import UIKit

final class #{name}: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var adapter = DefaultTableAdapter(tableView: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()

        adapter.reloadData()
    }
}

EOF

new_content =  lines[0...line].join + template

File.open(file_name, 'w'){|f| f.write new_content}

puts "Done"