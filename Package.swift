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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.1/MobilePaymentSDK.xcframework.zip",
            checksum: "3f50f371cf02738c57c2ea0ea8b188ac92ddb789d5a88013b10a5e5049eb0c47"
        )
    ]
)
