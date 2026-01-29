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
            checksum: "eacaf4cf1ec0359ee125ecae283d1bf31f019ffb7c2da06bfa0ff25bff39b29d"
        )
    ]
)
