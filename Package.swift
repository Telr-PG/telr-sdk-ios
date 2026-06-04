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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.2.0/MobilePaymentSDK.xcframework.zip",
            checksum: "4c72f044284354fe669cb6cd2c4b0ecf7a72bea38384036d86941c3b472e66be"
        )
    ]
)
