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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.21/MobilePaymentSDK.xcframework.zip",
            checksum: "bfb40a43fe4bc40f7f26816b3e0b6ff1634b97e2ecf2d93deed5b1395f4f3abe"
        )
    ]
)
