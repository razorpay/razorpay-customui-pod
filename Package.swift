// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageVersion = "test-0.0.1"


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

        // ── Binary Targets ────────────────────────────────────────────
        // Razorpay + RazorpayCore are uploaded to the GitHub Release
        // at the same tag as packageVersion — same release event as the
        // CocoaPod publish. Bump packageVersion to pick up new binaries.
        // Run .github/scripts/update_spm_checksums.sh to auto-fill checksums.
        // ─────────────────────────────────────────────────────────────
        .binaryTarget(
            name: "Razorpay",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/\(packageVersion)/Razorpay.xcframework.zip",
            checksum: "ae2e2ab991151dc7fcb5ad37aaaf58eb6a9ad6c3e665d3793f691195cfdf7c25"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/\(packageVersion)/RazorpayCore.xcframework.zip",
            checksum: "62047e8ba2d8380a35aba28d60a38d4feebc43d22afef82729209b35b689053a"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            path: "Pod/RazorpayCustom.xcframework"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
