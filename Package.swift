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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.20/MobilePaymentSDK.xcframework.zip",
            checksum: "be0b5cea2f9817a91f64a04bc83efbb10798fd9af6c9e2f041fca59ad691dcd4"
        )
    ]
)
