// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "MobilePaymentSDK",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "MobilePaymentSDK", targets: ["MobilePaymentSDK"])
    ],
    targets: [
        .binaryTarget(
            name: "MobilePaymentSDK",
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.13/MobilePaymentSDK.xcframework.zip",
            checksum: "98ea2151f3ac300e9880092758c51884c7a762951d548dfa9cd493cc55f34382"
        )
    ]
)
