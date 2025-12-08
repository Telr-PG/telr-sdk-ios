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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.0/MobilePaymentSDK.xcframework.zip",
            checksum: "f3d299ddc4ccc6995a4d06b2de265b9123c8a581dfe0942a875b72de7cdf4533"
        )
    ]
)
