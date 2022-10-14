#
# Be sure to run `pod lib lint Swifty.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name         = "RyukieSwifty"
  s.summary      = "Swifty for iOS by.RyukieSama"
  s.version      = "0.1.8"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/RyukieSama/Swifty'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RyukieSama' => 'ryukie.sama@gmail.com' }
  s.source           = { :git => 'https://github.com/RyukieSama/Swifty.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '11.0'

  s.swift_version = '5.0'
  
  s.source_files = 'Swifty/Classes/**/*'
  s.requires_arc = true
  
  # s.resource_bundles = {
  #   'Swifty' => ['Swifty/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Swifty/Classes/Core/**/*'
  end

  s.subspec 'UIKit' do |ss|
    ss.source_files = 'Swifty/Classes/UIKit/**/*'
    ss.dependency 'RyukieSwifty/Core'
  end

  s.subspec 'CloudKit' do |ss|
    ss.source_files = 'Swifty/Classes/CloudKit/**/*'
    ss.dependency 'RyukieSwifty/Core'
    ss.frameworks = 'CloudKit'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'Swifty/Classes/Foundation/**/*'
    ss.dependency 'RyukieSwifty/Core'
  end

  s.subspec 'FullScreen' do |ss|
    ss.source_files = 'Swifty/Classes/FullScreen/**/*'
    ss.dependency 'RyukieSwifty/Core'
  end

  s.subspec 'Router' do |ss|
    ss.source_files = 'Swifty/Classes/Router/**/*'
    ss.dependency 'RyukieSwifty/Core'
  end

  s.subspec 'SwiftyServiceProtocol' do |ss|
    ss.source_files = 'Swifty/Classes/SwiftyServiceProtocol/**/*'
    ss.dependency 'RyukieSwifty/Core'
  end

  s.subspec 'ScreenShield' do |ss|
    ss.source_files = 'Swifty/Classes/UIKit/UIView/View/ScreenShieldView.swift'
  end
  
end
