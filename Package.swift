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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.3/MobilePaymentSDK.xcframework.zip",
            checksum: "87e2e9ee3a04b7bb020bdc1063f8ba18e241e54093af6699d9430002260a3ff2"
        )
    ]
)
