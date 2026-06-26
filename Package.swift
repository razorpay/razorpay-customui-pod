// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.6"


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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.6/Razorpay.xcframework.zip",
            checksum: "a437bd68ad16b883216fcd8ac949dd03ae6206ef26a3ed81d7f4c89f1cc643aa"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.6/RazorpayCustom.xcframework.zip",
            checksum: "3a598e7646c48b69a6337b5bf955d157de5b8057070b62edbab40baedcedc214"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.6/RazorpayCore.xcframework.zip",
            checksum: "2e7681c56be2e6df4afdbf1f00ad8d636b6d5b8afcf3c398041f660978666b89"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.6/RazorpayApplePay.xcframework.zip",
            checksum: "b48ba5deccbdb17b243d52fe6ccd90f92057b7c31a8e737c427f995f2644052e"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
