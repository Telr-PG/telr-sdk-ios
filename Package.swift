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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.1.1/MobilePaymentSDK.xcframework.zip",
            checksum: "afb26a47a2f3b9156d4ba91ac4b703f7f0bb03bcb9b905b0df61113b9a57b650"
        )
    ]
)
