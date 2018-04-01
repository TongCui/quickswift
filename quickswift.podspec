Pod::Spec.new do |s|
  s.name        = "quickswift"
  s.version     = "0.0.1"
  s.summary     = "Quick swift"
  s.description  = <<-DESC
                    This is a quick swift.
                   DESC
  s.homepage    = "https://github.com/TongCui/quickswift"
  s.license     = { :type => "MIT" }
  s.author      = { "Tong Cui" => "tongcui.dev@gmail.com" }

  s.requires_arc = true
  # s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "10.0"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
  # s.source   = { :git => "https://github.com/TongCui/quickswift.git", :tag => s.version.to_s }
  s.source   = { :git => "https://github.com/TongCui/quickswift.git", :branch => "master" }
  # s.source   = { :git => "https://github.com/TongCui/quickswift.git" }
  s.source_files = "QuickSwift/QuickSwift/**/*.swift"
  s.dependency 'Alamofire', '~> 4.7.1'
  s.dependency "SnapKit", "~> 4.0.0"
end
