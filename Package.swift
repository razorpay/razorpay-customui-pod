// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-alpha.1"


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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-alpha.1/RazorpayCustom.xcframework.zip",
            checksum: "5c70aa931563615c85546692594c352e54758a06991d37e8fd315e01115283ab"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-alpha.1/RazorpayCore.xcframework.zip",
            checksum: "6706414f8ddbe76a8e5613a55d0f60cbd47e7e21de778cecaa5eb89d26628b6d"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-alpha.1/RazorpayApplePay.xcframework.zip",
            checksum: "89b77777481357108288656ae659acf29851c4f1ed245270e7f9e57bd643e8d3"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
