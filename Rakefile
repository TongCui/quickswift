task default: %w[test]

DESTINATION='platform=iOS Simulator,name=iPhone 8'

desc "swiftlint autocorrect"
task :lint do
  puts ">> swiftlint autocorrect"
  sh 'cd QuickSwift; swiftlint autocorrect'
end

desc "Update Dependencies [Carthage]"
task :update do
  puts ">> carthage update"
  sh 'cd QuickSwift; carthage update --platform iOS'
end

desc "Build"
task :buid do
  puts ">> xcodebuild build"
  sh "xcodebuild -workspace QuickSwift.xcworkspace -scheme QuickSwift -destination \"#{DESTINATION}\" build | xcpretty"
end

desc "Test"
task :test do 
  puts ">> xcodebuild build"
  sh "xcodebuild -workspace QuickSwift.xcworkspace -scheme QuickSwift -destination \"#{DESTINATION}\" test | xcpretty"
end

desc "Code Coverage"
task :coverage do 
  puts ">> slather"
  sh 'slather'
end

