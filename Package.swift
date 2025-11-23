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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.2.1/MobilePaymentSDK.xcframework.zip",
            checksum: "8b40ea741506ce3e3cbb0ba011acab06c84c76aaff8f67f5547209ddebfae44e"
        )
    ]
)
