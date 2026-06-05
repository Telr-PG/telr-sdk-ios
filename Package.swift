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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.3.0/MobilePaymentSDK.xcframework.zip",
            checksum: "a28f9b60a11c9deeffcd6832724d084f88590f5e338341d588790c22f2802031"
        )
    ]
)
