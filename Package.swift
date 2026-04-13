// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageVersion = "2.1.4"


let package = Package(
    name: "razorpay-customui-pod",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "RazorpayCoreSPM",
            targets: ["RazorpayCoreSPM"]
        ),
        .library(
            name: "RazorpayCustomUI",
            targets: ["RazorpayCustomUI"]
        ),
    ],
    targets: [
        .target(
            name: "RazorpayCoreSPM",
            dependencies: [
                .target(name: "Razorpay"),
                .target(name: "RazorpayCore"),
            ],
            path: "Sources/RazorpayCoreSPM"
        ),

        .target(
            name: "RazorpayCustomUI",
            dependencies: [
                .target(name: "RazorpayCoreSPM"),
                .target(name: "RazorpayCustom"),
            ],
            path: "RazorpayCustomUI/Sources"
        ),

        // ── Binary Targets ───────────────────────────────────
        // Update the <version> in the URL to match the release tag.
        // Run .github/scripts/update_spm_checksums.sh to auto-fill checksums.
        // ────────────────────────────────────────────────────────
        .binaryTarget(
            name: "Razorpay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/<version>/Razorpay.xcframework.zip",
            checksum: "<checksum>"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/<version>/RazorpayCore.xcframework.zip",
            checksum: "<checksum>"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            path: "Pod/RazorpayCustom.xcframework"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
