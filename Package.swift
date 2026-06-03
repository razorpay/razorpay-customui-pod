// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.5.0-beta.2"


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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.2/Razorpay.xcframework.zip",
            checksum: "fd764f29a90970d1f180e16671c3514b7f14ad3d484089558947ccfcbb337717"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.2/RazorpayCustom.xcframework.zip",
            checksum: "776ad73eb2937f9bdb5e550627aef08f3304bbdbabb6645271e49e7b7eb1e256"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.2/RazorpayCore.xcframework.zip",
            checksum: "58ca524ab0f44eb80709c005b7f5c39eec57a5b864f2e7767daaee12f8cf2101"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/1.5.0-beta.2/RazorpayApplePay.xcframework.zip",
            checksum: "9c5fc6391eedc9ff4f48ffc5e0101c206411f7a0c196bb4d3a9a86cdbd88c5e1"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
