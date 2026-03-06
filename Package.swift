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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.0.1/MobilePaymentSDK.xcframework.zip",
            checksum: "79675147cfeea2efe22748d0c80edf9602103aaba197a6c6af89ba8724cf3fa7"
        )
    ]
)
