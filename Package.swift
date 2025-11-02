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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.2.0/MobilePaymentSDK.xcframework.zip",
            checksum: "dbbf1f7f691e43135386a477abd698cb13dc76ffad150c675eb31ba23364adc7"
        )
    ]
)
