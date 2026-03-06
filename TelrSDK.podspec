Pod::Spec.new do |s|
  s.name             = 'TelrSDK'
  s.version          = '4.0.1'
  s.summary          = 'Telr iOS Payment SDK - accept payments seamlessly'
  s.homepage         = 'https://github.com/Telr-PG/telr-sdk-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = {"Your Company":"support@telr.com"}
  s.source           = { :git => 'https://github.com/Telr-PG/telr-sdk-ios.git', :tag => '4.0.1' }
  s.vendored_frameworks = 'Releases/ios-v4.0.1/MobilePaymentSDK.xcframework'
  s.platform         = :ios, '15.1'
  s.swift_version    = '6.0'
end
