#
#  Be sure to run `pod spec lint RHBase.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = 'RHBase'
  s.version      = '1.0.10'
  s.summary      = 'iOS常用基类'
  s.homepage     = 'https://github.com/guorenhao/RHBase'
  s.license      = 'MIT'
  s.authors      = {'Abner_G' => 'grh_1990@126.com'}
  s.platform     = :ios, '8.0'   
  s.source       = {:git => 'https://github.com/guorenhao/RHBase.git', :tag => s.version}
  s.source_files = 'RHBase/**/*.{h,m}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'MJRefresh', '~> 3.1.15.3'

end
