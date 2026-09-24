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
  s.version          = '1.0.0'
  s.summary          = "Apple Pay plugin for Razorpay's Custom Payment SDK"

  s.description      = <<-DESC
  Native Apple Pay plugin for Razorpay Custom Checkout on iOS. Presents the
  PassKit payment sheet and completes the payment through Razorpay. Opt-in:
  add this pod only if your app takes Apple Pay. Versioned independently of
  razorpay-customui-pod, like every other plugin pod; the checkout version it
  needs is expressed by the dependency below.
                       DESC

  s.homepage         = 'https://github.com/razorpay/razorpay-customui-pod.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Razorpay' => 'support@razorpay.com' }
  s.source           = { :git => 'https://github.com/razorpay/razorpay-customui-pod.git', :tag => "applepay-#{s.version.to_s}" }
  s.social_media_url = 'https://twitter.com/razorpay'

  # Matches the xcframework's MinimumOSVersion; PKPaymentButton styling APIs are iOS 12+.
  s.platform     = :ios, '12.0'

  s.vendored_frameworks = ['Pod/RazorpayApplePay.xcframework']
  s.frameworks          = 'PassKit'
  s.dependency 'razorpay-customui-pod', '~> 2.2.3'

end
