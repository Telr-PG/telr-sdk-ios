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
            checksum: "5c2bf1c656ba634d5d794c754c19ff79d6dbe964b593e21e5c1c57a1dd9c1553"
        )
    ]
)
