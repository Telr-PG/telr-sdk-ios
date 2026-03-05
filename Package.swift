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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.0.0/MobilePaymentSDK.xcframework.zip",
            checksum: "1f836e1ea7e530a9aa86452c0958cbe635ce95106b13cf429afa07288b706623"
        )
    ]
)
