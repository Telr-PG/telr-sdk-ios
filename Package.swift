// swift-tools-version:6.0

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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.18/MobilePaymentSDK.xcframework.zip",
            checksum: "cef2ef73a57e9dea6b1c0d64de6d656cccada1bdc10691b5c955888ed32144b9"
        )
    ]
)
