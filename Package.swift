// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "MobilePaymentSDK",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "MobilePaymentSDK", targets: ["MobilePaymentSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MobilePaymentSDK",
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.19/MobilePaymentSDK.xcframework.zip",
            checksum: "dbf584fe06bcd7c56ee72bcbcec47aa78e8b182fe016c0496783c5af3b1c2b21"
        )
    ]
)
