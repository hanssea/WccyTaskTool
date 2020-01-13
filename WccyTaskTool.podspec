#
# Be sure to run `pod lib lint WccyTaskTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WccyTaskTool'
  s.version          = '0.1.2'
  s.summary          = 'WccyTaskTool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 网络助手工具，目的为了形成单一颗粒组件，方便项目组各项目使用.
                       DESC

  s.homepage         = 'https://github.com/hanssea/WccyTaskTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hanssea' => 'jianye0209@yeah.net' }
  s.source           = { :git => 'https://github.com/hanssea/WccyTaskTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WccyTaskTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WccyTaskTool' => ['WccyTaskTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'AFNetworking'
  s.dependency 'MJExtension'
end
