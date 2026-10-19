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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/4.4.4/MobilePaymentSDK.xcframework.zip",
            checksum: "eaee620425c4bb2bce66a3965cd195241e42c8686dd640ac9cfb99040979fa8a"
        )
    ]
)
