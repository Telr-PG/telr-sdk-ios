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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.6/MobilePaymentSDK.xcframework.zip",
            checksum: "7dad8f8ce7da9ea5810747ab9a286a9c3f4e6ebf7ea715d489f6d43d9ca34483"
        )
    ]
)
