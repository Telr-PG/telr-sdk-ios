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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/ios-v0.0.5/MobilePaymentSDK.xcframework.zip",
            checksum: "97ec9b019deab8c026bc944eb0dc43862577866b40bb88ea1506dc1433200f73"
        )
    ]
)
