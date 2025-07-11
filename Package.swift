// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let packageVersion = "1.4.1"


let package = Package(
    name: "RazorpayCustomUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RazorpayCustomUI",
            targets: ["RazorpayWrapper"]
        ),
    ],
    targets: [
       .binaryTarget(
            name: "Razorpay",
            path: "Pod/Razorpay.xcframework"
        ),
        .target(
            name: "RazorpayWrapper",
            dependencies: ["Razorpay"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
