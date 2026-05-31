// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0"


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
                "RazorpayApplePayPlugin"
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
            name: "RazorpayApplePayPlugin",
            path: "Pod/RazorpayApplePayPlugin.xcframework"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
