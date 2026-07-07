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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/2.2.0/Razorpay.xcframework.zip",
            checksum: "a51208d8529b813e4625829f2fd0624651f1c4113f61507636096d6756284ba7"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/2.2.0/RazorpayCustom.xcframework.zip",
            checksum: "ba359c81870950f7f5dee5bc1f539adb028efe482335104d242bcc64ac59d021"
        ),

        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/2.2.0/RazorpayCore.xcframework.zip",
            checksum: "43905538520d5a74f3316567c5ecff945075ccd0e09ae38bb9b3de8f194272de"
        ),

        .binaryTarget(
            name: "RazorpayApplePay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/2.2.0/RazorpayApplePay.xcframework.zip",
            checksum: "c9e47f4e3edaee208f910ea4626b733da0767102768f8b0d806824ee84f62568"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
