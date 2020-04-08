#
# Be sure to run `pod lib lint oc-viper-base.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'oc-viper-base'
  s.version          = '0.1.4.5'
  s.summary          = '一个OC编写的类VIPER框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
一个OC编写的类VIPER框架，用于快速构架iOS应用，或桥接各种现成功能模块。
                       DESC

  s.homepage         = 'https://github.com/zsy78191/oc-viper-base'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zsy78191' => 'zcleeco@qq.com' }
  s.source           = { :git => 'https://github.com/zsy78191/oc-viper-base.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'oc-viper-base/Classes/**/*'
  
  # s.resource_bundles = {
  #   'oc-viper-base' => ['oc-viper-base/Assets/*']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ReactiveObjC'
  s.dependency 'MGJRouter'
  s.dependency 'PromiseKit'
  s.dependency 'SVProgressHUD'
  s.dependency 'IQKeyboardManager'
  s.dependency 'STPopup'
  s.dependency 'MagicalRecord'
  # s.dependency 'Classy'
  s.dependency 'Masonry'
  s.dependency 'RegexKitLite'
  s.dependency 'Mantle'
end
