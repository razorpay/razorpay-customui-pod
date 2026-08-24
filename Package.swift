// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "2.2.0"


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
            path: "Pod/core/Razorpay.xcframework"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            path: "Pod/RazorpayCustom.xcframework"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            path: "Pod/core/RazorpayCore.xcframework"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/2.2.0/RazorpayApplePay.xcframework.zip",
            checksum: "c9e47f4e3edaee208f910ea4626b733da0767102768f8b0d806824ee84f62568"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
