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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.1.0/MobilePaymentSDK.xcframework.zip",
            checksum: "bd8270a69cf017ad24fb582a4a2f34c634ded9eb31b0a6669dc57d8f4b631868"
        )
    ]
)
