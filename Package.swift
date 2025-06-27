// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "RazorpayCustomUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RazorpayCustomUI",
            targets: ["Razorpay"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "Razorpay",
            path: "Pod/Razorpay.xcframework"
        )
    ],
    swiftLanguageVersions: [.v5]
)