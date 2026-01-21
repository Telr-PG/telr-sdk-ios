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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.2/MobilePaymentSDK.xcframework.zip",
            checksum: "09828240434d128e24a9f6a9ab330ce84dfbf421db79477d55fe90cca3e1e8af"
        )
    ]
)
