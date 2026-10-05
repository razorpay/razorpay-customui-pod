# razorpay-applepay-pod

[![Version](https://img.shields.io/cocoapods/v/razorpay-applepay-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-applepay-pod)
[![License](https://img.shields.io/cocoapods/l/razorpay-applepay-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-applepay-pod)
[![Platform](https://img.shields.io/cocoapods/p/razorpay-applepay-pod.svg?style=flat)](https://cocoapods.org/pods/razorpay-applepay-pod)

Apple Pay plugin for Razorpay's Custom Checkout iOS SDK (`razorpay-customui-pod`). Opt-in: add it only if your app takes Apple Pay.

## Requirements

- iOS 12.0 or later
- A live Razorpay key with Apple Pay enabled (Apple Pay has no test mode)
- An Apple Pay merchant identifier registered with Razorpay and added to your app's entitlements
- A physical device with a supported card in Apple Wallet

## Installation

```ruby
pod 'razorpay-applepay-pod'
```

This also brings in `razorpay-customui-pod`. React Native apps using `react-native-customui` add the same line to `ios/Podfile`.

## Usage

Initialise checkout with the plugin:

```swift
import RazorpayCustom
import RazorpayApplePay

let razorpay = RazorpayCheckout.initWithKey(key, andDelegate: self,
                                           withPaymentWebView: webView,
                                           ApplePay: ApplePay.pluginInstance())
```

Pay with `method: "card"` and `app.name: "apple_pay"`:

```swift
razorpay.authorize([
    "amount": 100,
    "currency": "INR",
    "order_id": "order_XXXX",
    "email": "customer@example.com",
    "contact": "9999999999",
    "method": "card",
    "app": [
        "name": "apple_pay",
        "apple_pay": ["merchant_identifier": "merchant.com.yourcompany"]
    ]
])
```

Other options such as `notes` and `description` are forwarded with the payment.
