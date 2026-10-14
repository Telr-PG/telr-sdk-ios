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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.2/MobilePaymentSDK.xcframework.zip",
            checksum: "673ef8b2c4b341b2e2a6ac95fd5ffeab13de5c4b07229d5148d1c71d172424c4"
        )
    ]
)
