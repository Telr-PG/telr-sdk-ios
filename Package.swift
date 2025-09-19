// swift-tools-version:5.3
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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.15/MobilePaymentSDK.xcframework.zip",
            checksum: "638de5daddb6d3a8037704d862896f9f66d0c4fed92632704bb18d2f4b631061"
        )
    ]
)
