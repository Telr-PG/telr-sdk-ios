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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/3.0.1/MobilePaymentSDK.xcframework.zip",
            checksum: "a0bea34f7a5750c6c33067970ba92f02af2f49ed58ee57694483033a72ac8a6e"
        )
    ]
)
