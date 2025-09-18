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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.9/MobilePaymentSDK.xcframework.zip",
            checksum: "0f4e0943f7d92e2c438dc17b5969dc552a47f380321d50830568c48a25a5d396"
        )
    ]
)
