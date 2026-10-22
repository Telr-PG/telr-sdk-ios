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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.5/MobilePaymentSDK.xcframework.zip",
            checksum: "a0b6870346c824ed9a4a3045c22eae790baf547256303939a366bb15522a2817"
        )
    ]
)
