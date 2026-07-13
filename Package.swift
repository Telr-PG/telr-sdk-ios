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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.0/MobilePaymentSDK.xcframework.zip",
            checksum: "eff64a9e0c0f7a747858a7854f814ea91c0575db072efe417d518f43b2ed2573"
        )
    ]
)
