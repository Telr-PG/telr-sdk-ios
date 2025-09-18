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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.7/MobilePaymentSDK.xcframework.zip",
            checksum: "4e3bb5f871db7e3716e274ef2b4aad139b2209fd4157064880db1dbf583bfd93"
        )
    ]
)
