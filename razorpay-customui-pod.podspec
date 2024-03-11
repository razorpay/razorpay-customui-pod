#
# Be sure to run `pod lib lint razorpay-customui-pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'razorpay-customui-pod'
  s.version          = '2.0.10'
  s.summary          = "CocoaPod implementation of Razorpay's Custom Payment SDK"

  s.description      = <<-DESC
  Razorpay is a payments platform for e-commerce businesses in India. Razorpay
helps businesses accepts online payments via Credit Card, Debit Card, Net banking
 and Wallets from their end customers. Razorpay provides a secure link between
 merchant website, various issuing institutions, acquiring Banks and the payment
  networks. Razorpay is a developer oriented payment gateway and focuses on
  essentials such as 24x7 support, one line integration code and checkout
  experiences that are very customer friendly.
                       DESC

  s.homepage         = 'https://github.com/razorpay/razorpay-customui-pod.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Razorpay' => 'support@razorpay.com' }
  s.source           = { :git => 'https://github.com/razorpay/razorpay-customui-pod.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/razorpay'

  s.platform     = :ios, '11.0'
  
  s.vendored_frameworks = 'Pod/Razorpay.xcframework'
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
