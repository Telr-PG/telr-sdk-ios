// swift-tools-version:5.0
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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.10/MobilePaymentSDK.xcframework.zip",
            checksum: "391499d091b99a9e82fcb8897a7cd30c4b17e8649551364aeb7ba8e7babfa534"
        )
    ]
)
