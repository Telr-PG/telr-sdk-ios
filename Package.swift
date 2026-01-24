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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.4/MobilePaymentSDK.xcframework.zip",
            checksum: "854b6445b529a82014e380968c3543a2627be6ded0fb89b3c01af5567946bb93"
        )
    ]
)
