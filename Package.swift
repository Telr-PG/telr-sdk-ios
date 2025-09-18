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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.4/MobilePaymentSDK.xcframework.zip",
            checksum: "7d70634114947565936a4c5580f626de943d72ae79a778ab4966e220db4e8724"
        )
    ]
)
