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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.8/MobilePaymentSDK.xcframework.zip",
            checksum: "8bac7acadcfadf1a92ac8e28b54957b8924d64b192fd51c764082782b6dac47a"
        )
    ]
)
