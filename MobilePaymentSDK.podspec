Pod::Spec.new do |s|
  s.name             = 'MobilePaymentSDK'
  s.version          = '0.0.6'
  s.summary          = 'Telr iOS Payment SDK - accept payments seamlessly'
  s.homepage         = 'https://github.com/Telr-PG/telr-sdk-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = {"Your Company":"support@telr.com"}
  s.source           = { :git => 'https://github.com/Telr-PG/telr-sdk-ios.git', :tag => 'ios-v0.0.6' }
  s.vendored_frameworks = 'Releases/ios-v0.0.6/MobilePaymentSDK.xcframework'
  s.platform         = :ios, '18.5'
  s.swift_version    = '5.0'
end
