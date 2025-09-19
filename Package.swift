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
            url: "https://github.com/Telr-PG/telr-sdk-ios/releases/download/0.0.11/MobilePaymentSDK.xcframework.zip",
            checksum: "999c2a40bf92092dce0f6f85821afab67604807d75809b52bec48398a16fc77d"
        )
    ]
)
