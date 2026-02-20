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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.7/MobilePaymentSDK.xcframework.zip",
            checksum: "d167349aac5f28ab7f98aa0330c51ebed685797382210d72fe925c05b31f1aba"
        )
    ]
)
