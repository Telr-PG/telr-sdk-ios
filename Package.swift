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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.3/MobilePaymentSDK.xcframework.zip",
            checksum: "cf71be57559dff214e807881f02236bbc4ce4baf8b977dc0dc931766d3c0dd5b"
        )
    ]
)
