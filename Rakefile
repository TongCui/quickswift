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

desc "App Transport Security"
task :ats do
  puts ">> TODO"
end
