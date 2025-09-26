// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "MobilePaymentSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "MobilePaymentSDK", targets: ["MobilePaymentSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MobilePaymentSDK",
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.22/MobilePaymentSDK.xcframework.zip",
            checksum: "34cd2d28a1ba1c20f3333df06c427ec88a6cf8d21973d2595ca77d090d118543"
        )
    ]
)
