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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.17/MobilePaymentSDK.xcframework.zip",
            checksum: "a0372dfbd82e726e0773d84d832eb045f73980af40e1a4c977f1fb585ff8eb13"
        )
    ]
)
