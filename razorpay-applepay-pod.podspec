#
# Be sure to run `pod lib lint razorpay-applepay-pod.podspec' to ensure this is a
# valid spec before submitting.
#
# Opt-in Apple Pay plugin for Razorpay Custom Checkout. Lives beside
# razorpay-core-pod.podspec: same repo, own name, own tag prefix (applepay-).
# Merchants add `pod 'razorpay-applepay-pod'` to their Podfile; it is never a
# dependency of razorpay-customui-pod or react-native-customui.
#

Pod::Spec.new do |s|
  s.name             = 'razorpay-applepay-pod'
  s.version          = '2.2.4'
  s.summary          = "Apple Pay plugin for Razorpay's Custom Payment SDK"

  s.description      = <<-DESC
  Native Apple Pay plugin for Razorpay Custom Checkout on iOS. Presents the
  PassKit payment sheet and completes the payment through Razorpay. Opt-in:
  add this pod only if your app takes Apple Pay. Version tracks the
  razorpay-customui-pod release it was built with.
                       DESC

  s.homepage         = 'https://github.com/razorpay/razorpay-customui-pod.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Razorpay' => 'support@razorpay.com' }
  s.source           = { :git => 'https://github.com/razorpay/razorpay-customui-pod.git', :tag => "applepay-#{s.version.to_s}" }
  s.social_media_url = 'https://twitter.com/razorpay'

  s.platform     = :ios, '11.0'

  s.vendored_frameworks = ['Pod/RazorpayApplePay.xcframework']
  s.frameworks          = 'PassKit'
  s.dependency 'razorpay-customui-pod', '~> 2.2.4'

end
