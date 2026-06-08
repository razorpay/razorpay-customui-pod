// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.3"


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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.3/Razorpay.xcframework.zip",
            checksum: "070f852e60c195de743cc4bd899b506e9de19187bf1e3e249877ca71c171de32"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.3/RazorpayCustom.xcframework.zip",
            checksum: "ffbf212d739daa3bdc7de90ddc27c7d09e7a14939b1d05abb1583556de1c1864"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.3/RazorpayCore.xcframework.zip",
            checksum: "06ef6f72978aa5a9bae99eb7d8e73d5184aab4aecca3e4f91725e299cdf1df34"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.3/RazorpayApplePay.xcframework.zip",
            checksum: "ea716ffefadc71bccb13866ada852aaa8ec24167b793d952f219052c2742ef4b"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
