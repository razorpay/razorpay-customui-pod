// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.1"


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
            path: "Pod/core/Razorpay.xcframework"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.1/RazorpayCustom.xcframework.zip",
            checksum: "106b53d5e13231b1f6bcb9238f193d29ff6cc3a32f6c1df3fd909305cc121e0d"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.1/RazorpayCore.xcframework.zip",
            checksum: "51b64352784404aebe01e52f88ccf1cd497e3fcaa7382e8c27156ebe37657573"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.1/RazorpayApplePay.xcframework.zip",
            checksum: "302e60fcd83ecd8a6297830f8590e3216d122fa88dea6c2e56ce038f208ce2e8"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
