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
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/test-0.0.1/Razorpay.xcframework.zip",
            checksum: "52286a896782f4476027e19b39cf507108287edc47e477189e4ca87711439c5f"
        ),
        .binaryTarget(
            name: "RazorpayCore",
            url: "https://github.com/razorpay/razorpay-customui-pod/releases/download/test-0.0.1/RazorpayCore.xcframework.zip",
            checksum: "2a1d307d088696e4a5d39d4686864a16ecc31e2399b959586a9e58202ff012f9"
        ),

        .binaryTarget(
            name: "RazorpayCustom",
            path: "Pod/RazorpayCustom.xcframework"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
