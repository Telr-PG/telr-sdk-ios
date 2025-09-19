// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "MobilePaymentSDK",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "MobilePaymentSDK", targets: ["MobilePaymentSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MobilePaymentSDK",
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.16/MobilePaymentSDK.xcframework.zip",
            checksum: "8bafe8b64278c997f880db1c1187d4fbb0edee78e2ba0f97dd4e61089b71f183"
        )
    ]
)
