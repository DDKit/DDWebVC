#
# Be sure to run `s.dependency lib lint DDWebVC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDWebVC'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DDWebVC.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  
TODO: Add long description of the s.dependency here.

                       DESC

  s.homepage         = 'https://github.com/DD/DDWebVC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DD' => 'duanchanghe@gmail.com' }
  s.source           = { :git => 'https://github.com/DDKit/DDWebVC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DDWebVC/Classes/**/*'
  
  s.resource_bundles = {
    'DDWebVC' => ['DDWebVC/Assets/*.png']
  }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.swift_version = '4.0'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'  #网络请求
  s.dependency 'SVProgressHUD' #加载动画
  s.dependency 'Hue' # 颜色
  s.dependency 'SwiftyJSON' #Json解析
  s.dependency 'SnapKit' #界面布局
  s.dependency 'JPush' #极光推送
  s.dependency 'ReachabilitySwift' #网络监听
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'DeviceKit'
  s.dependency 'SwiftDate'
  s.dependency 'CryptoSwift' #加密
  
  
end
