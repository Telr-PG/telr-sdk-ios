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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.6/MobilePaymentSDK.xcframework.zip",
            checksum: "3327975168f59a1d463b191dbb032281c788ce186b7bfcf7ab5775a3f0868ad5"
        )
    ]
)
