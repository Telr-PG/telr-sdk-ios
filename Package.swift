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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.5/MobilePaymentSDK.xcframework.zip",
            checksum: "16495aeaaae729e7605665570fb713a246316d16c920fda91564e526a61f27f4"
        )
    ]
)
