// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.5"


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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.5/Razorpay.xcframework.zip",
            checksum: "12cbbc804503efccb05aa0e6ce877e2cd75c02d392a50a0ff6622fe8ce6c9f10"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.5/RazorpayCustom.xcframework.zip",
            checksum: "184c964acbb24898a4ecc4c27cc3ce83611753f30addd50a8083420c30cdc34c"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.5/RazorpayCore.xcframework.zip",
            checksum: "3b53b7debc6f4dd1ca58af7a8a89bd27fce62bed32757be4067961c61253f1b3"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.5/RazorpayApplePay.xcframework.zip",
            checksum: "9acc29b2aaeb23ea9b560e4408ecda38365e6848f3792a99a8058cab56ebd6da"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
