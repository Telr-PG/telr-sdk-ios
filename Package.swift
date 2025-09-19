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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.14/MobilePaymentSDK.xcframework.zip",
            checksum: "99282433575f5867b369312f3befa2a88628c635fec26cc309c1efa57e8880cd"
        )
    ]
)
