Pod::Spec.new do |s|
  s.name         = "Swifty"
  s.summary      = "Swifty for iOS by.RyukieSama"
  s.version      = "0.0.1"
  # s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Ryukie" => "ryukie.sama@gmail.com" }
  s.homepage     = "https://github.com/RyukieSama/Swifty.git"
  s.platform     = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source       = { :git => 'https://github.com/RyukieSama/Swifty.git', :tag => s.version}
  s.requires_arc = true
  s.source_files = 'Swifty/**/*.swift'

end
