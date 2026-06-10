// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.4"


let package = Package(
    name: "RazorpayCustomUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RazorpayCustomUI",
            targets: [
                "RazorpayCustomUI",
                "Razorpay",
                "RazorpayCustom",
                "RazorpayCore",
                "RazorpayApplePay"
            ]
        ),
        .library(
            name: "RazorpayApplePay",
            targets: [
                "RazorpayApplePay",
                "Razorpay",
                "RazorpayCustom",
                "RazorpayCore"
            ]
        ),
    ],
    targets: [
       .target(
            name: "RazorpayCustomUI",
            dependencies: [
                .target(name: "Razorpay"),
                .target(name: "RazorpayCore"),
                .target(name: "RazorpayCustom"),
            ],
            path: "sources/RazorpayWrapper"
        ),

        .binaryTarget(
            name: "Razorpay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.4/Razorpay.xcframework.zip",
            checksum: "2bd4e978b3907ba1584d65abf4c425e1d318245360d890e3e24fc571bc28c763"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.4/RazorpayCustom.xcframework.zip",
            checksum: "6fcf4b90f86dee29d57d524139c9b6b71b2e26517a230bc327e94da4302e8a5b"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.4/RazorpayCore.xcframework.zip",
            checksum: "22cc3fdac5570ddbeffd46ad8fc881d8ac8785c1434a7d58fbd7469d506a5d08"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.4/RazorpayApplePay.xcframework.zip",
            checksum: "956ee02f52d97634dd8385b551b9303ccfdbb4bb391230766431917b04c372fb"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
