task default: %w[test]

DESTINATION = 'platform=iOS Simulator,name=iPhone 8'
PROJECT = 'QuickSwift'


desc "swiftlint autocorrect"
task :lint do
  puts ">> swiftlint autocorrect"
  sh "cd QuickSwift; swiftlint autocorrect"
end

desc "Update Dependencies [Carthage]"
task :update do
  puts ">> carthage update"
  sh "cd QuickSwift; carthage update --platform iOS"
end

desc "Build"
task :buid do
  puts ">> xcodebuild build"
  sh "xcodebuild -workspace #{PROJECT}.xcworkspace -scheme #{PROJECT} -destination \"#{DESTINATION}\" build | xcpretty"
end

desc "Test"
task :test do 
  puts ">> xcodebuild build"
  sh "xcodebuild -workspace #{PROJECT}.xcworkspace -scheme #{PROJECT} -destination \"#{DESTINATION}\" test | xcpretty"
end

desc "Code Coverage"
task :coverage do 
  puts ">> slather"
  sh "slather"
end

desc "Open workspace"
task :open do
  sh "open #{PROJECT}.xcworkspace"
end

desc "Playground tips"
task :playground do
  tips = """
    ======async call=======
    PlaygroundPage.current.needsIndefiniteExecution = true
    PlaygroundPage.current.finishExecution()
    =========
  """
  puts tips
end

desc "App Transport Security"
task :ats, [:command] do |task, args|
  command = args[:command]
  if command == "add"
    puts ">> add ATS"  
  else
    puts ">> remove ATS"
  end
  ruby "./scripts/ats/ats.rb #{command}"
end

desc "Setup New ViewController"
# rake setupvc[ViewController]
task :setupvc, [:vc] do |task, args|
  vc = args[:vc]
  puts "ViewController => #{vc}"
  ruby "./scripts/xcode/xcode_setup_new_vc.rb #{vc}"
end

desc "Generate Segue Enum"
task :segue do
  ruby 'scripts/xcode/xcode_find_segue.rb'
end

desc "Update Storyboard files"
task :storyboard do
  ruby 'scripts/xcode/xcode_update_storyboard.rb'
end
