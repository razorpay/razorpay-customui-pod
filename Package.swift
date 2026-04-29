// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let packageVersion = "2.1.4"
let binaryVersion = "1.5.4-rc.2"

let package = Package(
    name: "RazorpayCustomUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RazorpayCustomUI",
            targets: ["RazorpayBinary", "RazorpayCore", "RazorpayCustom"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "RazorpayBinary",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/Razorpay.xcframework.zip",
            checksum: "773873f1e7b30142d092cd087c60c3ebd5afd525e51168408e31274143e0f994"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCore.xcframework.zip",
            checksum: "f95455205642b5814c6d4b83a533279165d0816e230f09b2a47908c2aff35679"
        ),
        .binaryTarget(
            name: "RazorpayCustom",
            url: "https://github.com/razorpay/razorpay-pod/releases/download/\(binaryVersion)/RazorpayCustom.xcframework.zip",
            checksum: "5e740709f8f4ed265a3fee9f51c2d213daba7ae3eaeb64f07660823cab9d76fa"
        ),
    ],
    swiftLanguageVersions: [.v5]
)

