# Telr iOS Payments SDK

<div align="center">
  <img src="docs/assets/images/telr-header.svg" alt="Telr Mobile Payment SDK" width="100%" height="200px">
</div>

<br />
<br />

Bring Telr’s trusted payment experience into your iOS app with minimal effort. The SDK handles payment screens, security, and transaction flow while you stay focused on your customer journey. Your users enjoy a smooth, native in-app checkout.

## Table of Contents

1. [Overview](#overview)
2. [Installation](#installation)
3. [Quick Start](#quick-start)
4. [Configuration](#configuration)
5. [Payment Methods](#payment-methods)
6. [Add Card Flow](#add-card-flow)
7. [Pay with Saved Card Flow](#pay-with-saved-card-flow)
8. [Pay with Card Flow](#pay-with-card-flow)
9. [Error Handling](#error-handling)
9. [Internationalization](#internationalization)
10. [Troubleshooting](#troubleshooting)
11. [API Reference](#api-reference)
12. [Support](#support)

## Overview

The Telr Mobile Payment SDK for iOS is a comprehensive payment solution that enables merchants to accept payments seamlessly within their iOS applications. Built with SwiftUI and following modern iOS development patterns, it provides a clean, secure, and customizable payment experience.

### Key Features

- **Multiple Payment Methods**: Credit/Debit Cards, Apple Pay, Click to Pay, Tabby, Tamara, STC Bank
- **3D Secure Support**: Built-in 3DS authentication flow
- **Saved Cards**: Tokenization and card management
- **Modern UI**: SwiftUI-based interface with iOS design guidelines
- **Internationalization**: Multi-language support (English, Arabic)
- **Security**: PCI DSS compliant with tokenization
- **Accessibility**: Full accessibility support for inclusive design

### Requirements

- iOS 15.1+
- Swift 6.0+
- Xcode 15.0+
- CocoaPods 1.11+ (if using CocoaPods)

## Installation

### CocoaPods

1. **Install CocoaPods** (if not already installed):
   ```bash
   sudo gem install cocoapods
   ```

2. **Create or update your Podfile**:
   ```ruby
   platform :ios, '15.1'
   
   use_frameworks!
   inhibit_all_warnings!
   
   target 'YourAppTarget' do
     pod 'TelrSDK', '~> 4.1.1'
   end
   ```

3. **Install the SDK**:
   ```bash
   pod install
   ```

4. **Open the workspace**:
   ```bash
   open YourApp.xcworkspace
   ```

5. **Import the SDK** in your Swift files:
   ```swift
   import MobilePaymentSDK
   ```

#### CocoaPods Troubleshooting

The `TelrSDK` pod is published from [github.com/Telr-PG/telr-sdk-ios](https://github.com/Telr-PG/telr-sdk-ios) and resolves via the standard CocoaPods CDN — no extra source configuration is required. If `pod install` cannot find it, run `pod repo update` and try again.

If you encounter build issues with newer Xcode versions, add this to your Podfile:

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |t|
    t.build_configurations.each do |config|
      config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
    end
  end
  installer.aggregate_targets.each do |t|
    t.user_project.native_targets.each do |nt|
      nt.build_configurations.each do |config|
        config.build_settings['ENABLE_USER_SCRIPT_SANDBOXING'] = 'NO'
      end
    end
  end
end
```

### Swift Package Manager (Recommended)

#### Via Xcode (Recommended)

1. In Xcode, go to **File > Add Package Dependencies**
2. Enter the repository URL: `https://github.com/Telr-PG/telr-sdk-ios`
3. Select version rule (e.g., "Up to Next Major") and pick release (e.g., 4.0.1)
4. Add the product `MobilePaymentSDK` to your target

#### Via Package.swift

```swift
// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "YourApp",
    platforms: [
        .iOS(.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/Telr-PG/telr-sdk-ios.git", .upToNextMajor(from: "4.1.1"))
    ],
    targets: [
        .target(
            name: "YourApp",
            dependencies: [
                .product(name: "MobilePaymentSDK", package: "telr-sdk-ios")
            ]
        )
    ]
)
```

### Carthage

1. **Add to Cartfile**:
   ```ogdl
   binary "https://raw.githubusercontent.com/Telr-PG/telr-sdk-ios/main/MobilePaymentSDK.json" ~> 4.1.1
   ```

2. **Update dependencies**:
   ```bash
   carthage update --use-xcframeworks --platform iOS
   ```

3. **Add to Xcode**:
   - Drag `Carthage/Build/MobilePaymentSDK.xcframework` into your project
   - Set to "Embed & Sign" in Frameworks, Libraries, and Embedded Content

### Manual Installation

1. **Download the framework**:
   - Download `MobilePaymentSDK.xcframework.zip` from [Releases](https://github.com/Telr-PG/telr-sdk-ios/releases)
   - Unzip to get `MobilePaymentSDK.xcframework`

2. **Add to Xcode**:
   - Drag the framework into your project navigator
   - Check "Copy items if needed" and select your target
   - Set to "Embed & Sign" in project settings

## Quick Start

### Basic Implementation

```swift
import SwiftUI
import MobilePaymentSDK

struct PaymentView: View {
    @State private var showPayment = false
    private let paymentSDK = PaymentSDK()
    
    var body: some View {
        VStack {
            Button("Pay Now") {
                showPayment = true
            }
        }
        .fullScreenCover(isPresented: $showPayment) {
            paymentSDK.paymentView(
                tokenURL: "https://api.telr.com/token",
                orderURL: "https://api.telr.com/order/123",
                onFinish: { response in
                    if response.success {
                        print("Payment successful: \(response.message)")
                    } else {
                        print("Payment failed: \(response.message)")
                    }
                    showPayment = false
                }
            )
        }
    }
}
```

### UIKit Integration

```swift
import UIKit
import MobilePaymentSDK

class PaymentViewController: UIViewController {
    private let paymentSDK = PaymentSDK()
    
    func showPayment() {
        let paymentView = paymentSDK.paymentView(
            tokenURL: "https://api.telr.com/token",
            orderURL: "https://api.telr.com/order/123",
            onFinish: { response in
                DispatchQueue.main.async {
                    if response.success {
                        self.showAlert(title: "Success", message: response.message)
                    } else {
                        self.showAlert(title: "Error", message: response.message)
                    }
                }
            }
        )
        
        let hostingController = UIHostingController(rootView: paymentView)
        present(hostingController, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
```

## Configuration

### Basic Configuration

```swift
let configuration = PaymentSDKConfiguration(
    debugLoggingEnabled: false,
    preferredLanguageCode: "en"
)

let paymentSDK = PaymentSDK(configuration: configuration)
```

### Builder Pattern Configuration

```swift
let configuration = PaymentSDKConfiguration.builder()
    .withDebugLoggingEnabled(true) // Enable for development
    .withPreferredLanguageCode("ar") // Arabic support
    .build()

let paymentSDK = PaymentSDK(configuration: configuration)
```

### Configuration Options

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `debugLoggingEnabled` | Bool | `false` | Enable debug logging (development only) |
| `preferredLanguageCode` | String? | `nil` | Override language ("en", "ar") |
| `applePayMerchantIdentifier` | String? | `nil` | Apple Pay merchant ID (e.g. `merchant.com.yourcompany.yourapp`). Required for Apple Pay to appear. |
| `applePayButtonType` | `PKPaymentButtonType` | `.plain` | Apple Pay button label (`.buy`, `.checkout`, `.book`, `.donate`, etc.) |
| `applePayButtonStyle` | `PKPaymentButtonStyle` | `.automatic` | Apple Pay button style (`.black`, `.white`, `.whiteOutline`, `.automatic`) |

### Runtime Configuration Updates

```swift
// Update configuration at runtime
let newConfig = PaymentSDKConfiguration.builder()
    .withPreferredLanguageCode("ar")
    .build()

paymentSDK.updateConfiguration(newConfig)
```

**Note**: Views already created with `paymentView` will not automatically pick up configuration changes. Create a new view after updating configuration if you need the new config applied.

## Payment Methods

### Supported Payment Methods

The SDK supports the following payment methods:

1. **Credit/Debit Cards**
   - Visa, Mastercard, American Express
   - 3D Secure authentication
   - Card tokenization for future payments

2. **Apple Pay**
   - Native Apple Pay integration
   - Touch ID/Face ID authentication
   - Secure element processing

3. **Tabby (Buy Now Pay Later)**
   - Displayed when enabled in the order (`allowedPaymentMethods` / relevant order links)
   - SDK-managed redirect/return flow

4. **Tamara (Buy Now Pay Later)**
   - Displayed when enabled in the order (`allowedPaymentMethods` / relevant order links)
   - SDK-managed redirect/return flow

5. **STC Bank**
   - Displayed when enabled in the order (`allowedPaymentMethods` / relevant order links)
   - SDK-managed data capture and submission flow

6. **Click to Pay (Mastercard SRC)**
   - Displayed when your order enables `allowedPaymentMethods.type = CLICK_TO_PAY` (or `order._links.clicktopay.href` is present).
   - **No SDK configuration or merchant registration required.** `dpaId`, acquirer config, and locale come from the order response — Telr's backend owns the network registration.
   - The SDK handles consumer recognition, email entry, OTP authentication, saved-card listing, manual card entry, the network DCF challenge UI, and 3DS internally.
   - Recognition tokens are persisted on-device per `dpaId` so returning users skip the email/OTP step on the next session.

### Card Payment Features

#### New Card Payment
- Real-time card validation
- BIN lookup for card scheme detection
- CVV and expiry validation
- Cardholder name validation

#### Saved Cards
- Tokenized card storage
- Quick payment with saved cards
- Card management (view/delete)

#### 3D Secure Authentication
- Automatic 3DS challenge handling
- WebView-based authentication flow
- Seamless user experience

### Apple Pay Integration

Apple Pay is automatically available when:
- Device supports Apple Pay
- User has cards in Wallet
- Merchant has Apple Pay enabled

#### Apple Pay Setup

1. **Apple Developer Portal**: Enable Apple Pay for your App ID and create a Merchant Identity Certificate under **Certificates, Identifiers & Profiles > Identifiers > Merchant IDs**.
2. **Xcode**: Add the **Apple Pay** capability to your target under **Signing & Capabilities** and select your Merchant ID.
3. **SDK Configuration**: Pass your Merchant Identifier when initializing the SDK:

```swift
let configuration = PaymentSDKConfiguration.builder()
    .withApplePayMerchantIdentifier("merchant.com.yourcompany.yourapp")
    .build()

let paymentSDK = PaymentSDK(configuration: configuration)
```

You can also customize the Apple Pay button:

```swift
let configuration = PaymentSDKConfiguration.builder()
    .withApplePayMerchantIdentifier("merchant.com.yourcompany.yourapp")
    .withApplePayButtonType(.buy)
    .withApplePayButtonStyle(.black)
    .build()
```

The SDK handles Apple Pay availability detection and presents the option when appropriate.

#### Common reasons Apple Pay does not appear

1. `applePayMerchantIdentifier` not passed to `PaymentSDKConfiguration` (or empty).
2. Device cannot make Apple Pay payments (`PKPaymentAuthorizationViewController.canMakePayments()` returns `false`) — typically because the device is unsupported or has no cards in Wallet.
3. The order's `allowedPaymentMethods` does not include `APPLE_PAY` — confirm Apple Pay is enabled on the Telr merchant account.
4. The order's `_links.applePay.href` is missing.

## Add Card Flow

Use `addCardView` when you want to verify and save a new card (without immediate checkout capture).

### Merchant-side flow

1. Merchant backend creates a VERIFY order.
2. Merchant backend returns `tokenUrl` + `orderUrl` to the app.
3. App opens SDK add-card sheet with those URLs.
4. SDK handles card entry, 3DS, and completion callback.
5. On success callback, app calls merchant backend completion endpoint to sync saved cards (for example, `/add-card/complete`).

### SwiftUI Example

```swift
paymentSDK.addCardView(
    tokenURL: addCardTokenURL,
    orderURL: addCardOrderURL
) { response in
    if response.success {
        // response.ref — payment reference from the VERIFY transaction (store for saved-card payments)
        // response.maskedName — masked cardholder name (store for SDKSavedCardInput)
        // response.savedCards — refreshed saved cards list
    } else {
        // show response.message
    }
}
```

## Pay with Saved Card Flow

Use `payWithSavedCardView` when a customer selects a saved card and CVV re-entry and/or 3DS is required (typically for higher-value transactions per your risk policy).

> **Note**: For low-value transactions your backend can process the saved card silently using `class: CONT` without opening the SDK — no CVV or user interaction needed. Use `payWithSavedCardView` (ECOM) when your risk policy requires CVV re-entry or 3DS authentication.

### Merchant-side flow

1. Merchant backend creates a SALE order.
2. Merchant backend returns `tokenUrl` + `orderUrl` to the app.
3. App opens the SDK saved-card sheet with those URLs and the saved card details.
4. SDK displays the masked card (read-only) and prompts for CVV only.
5. SDK handles payment, 3DS, and calls the completion callback.

### SwiftUI Example

```swift
let savedCard = SDKSavedCardInput(
    token: "card_token_here",
    maskedCard: "**** 1111",   // masked card from add-card flow (e.g. SavedCard.maskedCard)
    expiry: "12/30",
    scheme: "VISA",
    maskedName: "J*** D**"    // optional, shown on the sheet
)

paymentSDK.payWithSavedCardView(
    tokenURL: checkoutTokenURL,
    orderURL: checkoutOrderURL,
    savedCard: savedCard
) { response in
    if response.success {
        // payment complete
    } else {
        // show response.message
    }
}
```

## Pay with Card Flow

Use `payWithCardView` when you want to collect card details and process an immediate payment (e.g., gift card purchases) without saving the card.

### Merchant-side flow

1. Merchant backend creates a SALE order.
2. Merchant backend returns `tokenUrl` + `orderUrl` to the app.
3. App opens SDK pay-with-card sheet with those URLs.
4. SDK handles card entry, BIN lookup (including international card blocking), 3DS, and completion callback.
5. On success callback, the payment is complete.

### SwiftUI Example

```swift
paymentSDK.payWithCardView(
    tokenURL: checkoutTokenURL,
    orderURL: checkoutOrderURL
) { response in
    if response.success {
        // payment complete
    } else {
        // show response.message
    }
}
```

## Error Handling

### SDK Response Format

Checkout operations return:

```swift
public struct SDKPaymentResponse {
    public let success: Bool
    public let message: String
    public let errorCode: String?
}
```

Add-card operations return:

```swift
public struct SDKAddCardResponse {
    public let success: Bool
    public let message: String
    public let errorCode: String?
    public let ref: String?              // payment reference from the VERIFY transaction
    public let savedCards: [SavedCard]?
    public let maskedName: String?       // e.g. "J*** D**"
}
```

### Common Error Scenarios

#### Network and Server Errors
```swift
.onFinish { response in
    if !response.success {
        switch response.errorCode {
        case "timeout":
            // Handle session timeout
            break
        case let code?:
            // Handle gateway/backend specific codes
            print("Payment failed with code: \(code)")
            break
        default:
            // Network/server failures may be provided as message text
            print("Payment failed: \(response.message)")
            print("Error code: \(response.errorCode ?? "Unknown")")
            break
        }
    }
}
```

#### Payment Failures
```swift
.onFinish { response in
    if !response.success {
        // Payment failed
        print("Payment failed: \(response.message)")
        print("Error code: \(response.errorCode ?? "Unknown")")
        
        // Show user-friendly error message
        showErrorAlert(message: response.message)
    } else {
        // Payment successful
        print("Payment successful: \(response.message)")
        showSuccessAlert(message: response.message)
    }
}
```

### Error Codes Reference

| Error Code | Description | Action Required |
|------------|-------------|-----------------|
| `timeout` | SDK session timed out | Retry checkout |
| `<gateway_code>` | Code returned by payment backend/order response | Log and map to merchant-friendly message |

## Internationalization

### Supported Languages

- **English** (Base) - Default
- **Arabic** (`ar`) - RTL support

### Language Configuration

#### Automatic Language Detection
By default, the SDK follows the host app's preferred language:

```swift
let paymentSDK = PaymentSDK() // Uses system language
```

#### Manual Language Override
```swift
let configuration = PaymentSDKConfiguration.builder()
    .withPreferredLanguageCode("ar") // Force Arabic
    .build()

let paymentSDK = PaymentSDK(configuration: configuration)
```

### RTL Support

The SDK fully supports right-to-left (RTL) languages:
- Automatic layout direction detection
- Proper text alignment
- Icon and image mirroring
- Form field positioning

## Troubleshooting

### Common Issues

#### 1. "No such module 'MobilePaymentSDK'"

**Causes:**
- Framework not properly linked
- Wrong import statement
- Build configuration issue

**Solutions:**
- Ensure framework is added to "Frameworks, Libraries, and Embedded Content"
- Check that you're importing `MobilePaymentSDK` (not `TelrSDK`)
- Clean build folder and rebuild

#### 2. "Image not found" at Runtime

**Causes:**
- Framework not embedded
- Architecture mismatch

**Solutions:**
- Set framework to "Embed & Sign" in project settings
- Ensure you're using the correct XCFramework for your target architecture

#### 3. CocoaPods Build Errors

**Causes:**
- Script sandboxing enabled
- Derived data corruption
- Pod cache issues

**Solutions:**
```bash
# Clean derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/*

# Clean pod cache
pod cache clean --all

# Reinstall pods
pod deintegrate
pod install
```

#### 4. Carthage Framework Issues

**Causes:**
- Not using XCFrameworks
- Framework not properly embedded

**Solutions:**
```bash
# Ensure XCFrameworks are used
carthage update --use-xcframeworks --platform iOS

# Verify framework is embedded
# Check project settings > Frameworks, Libraries, and Embedded Content
```

#### 5. Payment Not Processing

**Causes:**
- Invalid URLs
- Network connectivity
- Server configuration

**Solutions:**
- Verify token and order URLs are correct
- Check network connectivity
- Enable debug logging to see detailed error messages
- Verify server endpoints are accessible

### Debug Logging

Enable debug logging for development:

```swift
let configuration = PaymentSDKConfiguration.builder()
    .withDebugLoggingEnabled(true)
    .build()

let paymentSDK = PaymentSDK(configuration: configuration)
```

Debug logs will show:
- Network requests and responses
- Error details
- SDK internal state
- Validation results

### Performance Optimization

#### Memory Management
- The SDK automatically manages memory for payment views
- Views are released when payment completes or is cancelled
- No manual cleanup required

#### Network Optimization
- Requests are automatically retried on failure
- Timeout intervals are managed internally by the SDK

## API Reference

### PaymentSDK

Main SDK class for payment processing.

```swift
public class PaymentSDK {
    public init(configuration: PaymentSDKConfiguration = PaymentSDKConfiguration())
    public func updateConfiguration(_ configuration: PaymentSDKConfiguration)
    
    @MainActor
    public func paymentView(
        tokenURL: String,
        orderURL: String,
        onFinish: @escaping (SDKPaymentResponse) -> Void
    ) -> some View

    @MainActor
    public func addCardView(
        tokenURL: String,
        orderURL: String,
        onFinish: @escaping (SDKAddCardResponse) -> Void
    ) -> some View

    @MainActor
    public func payWithCardView(
        tokenURL: String,
        orderURL: String,
        onFinish: @escaping (SDKPaymentResponse) -> Void
    ) -> some View

    @MainActor
    public func payWithSavedCardView(
        tokenURL: String,
        orderURL: String,
        savedCard: SDKSavedCardInput,
        onFinish: @escaping (SDKPaymentResponse) -> Void
    ) -> some View
}
```

### PaymentSDKConfiguration

Configuration class for SDK customization.

```swift
public struct PaymentSDKConfiguration {
    public let debugLoggingEnabled: Bool
    public let preferredLanguageCode: String?
    
    public static func builder() -> Builder
    public init(builder configure: (inout Builder) -> Void)
}
```

### SDKPaymentResponse

Response object for payment operations.

```swift
public struct SDKPaymentResponse {
    public let success: Bool
    public let message: String
    public let errorCode: String?
    
    public static func success(message: String) -> SDKPaymentResponse
    public static func failure(message: String, errorCode: String?) -> SDKPaymentResponse
}
```

### SDKSavedCardInput

Input struct passed to `payWithSavedCardView`. Contains the saved card details to display on the payment sheet.

```swift
public struct SDKSavedCardInput {
    public let token: String        // card token from add-card flow
    public let maskedCard: String   // e.g. "**** 1111"
    public let expiry: String       // e.g. "12/30"
    public let scheme: String       // e.g. "VISA"
    public let maskedName: String?  // optional, e.g. "J*** D**"
}
```

### SDKAddCardResponse

Response object for add-card operations.

```swift
public struct SDKAddCardResponse {
    public let success: Bool
    public let message: String
    public let errorCode: String?
    public let ref: String?           // payment reference from the VERIFY transaction
    public let savedCards: [SavedCard]?
    public let maskedName: String?    // e.g. "J*** D**", use for SDKSavedCardInput
}
```

### Order Model

Order information structure.

```swift
public struct Order {
    public let ref: String
    public let amount: Amount
    public let status: OrderStatus
    public let allowedPaymentMethods: [PaymentMethod]?
    public let _links: OrderLinks?
    public let payments: [PaymentResponse]?
}
```

### Amount Model

Payment amount structure.

```swift
public struct Amount {
    public let value: String
    public let currency: String?
}
```

### PaymentMethod

Supported payment method entry returned with an order.

```swift
public struct PaymentMethod {
    public let schemes: [String]          // e.g. ["VISA", "MASTERCARD"]
    public let type: PaymentMethodType    // .card, .applePay, .tabby, .stcBank
}
```

### PaymentMethodType

Type of payment method available for the order.

```swift
public enum PaymentMethodType: String {
    case card = "CARD"
    case applePay = "APPLE_PAY"
    case tabby = "TABBY"
    case tamara = "TAMARA"
    case stcBank = "STC_BANK"
    case clickToPay = "CLICK_TO_PAY"
}
```

### OrderStatus

High-level status of the order.

```swift
public enum OrderStatus: String {
    case pending = "PENDING"
    case authorised = "AUTHORISED"
    case paid = "PAID"
    case cancelled = "CANCELLED"
    case declined = "DECLINED"
}
```

### OrderLinks (SDK-internal)

Links to operations/endpoints associated with the order (card, Apple Pay, 3DS, etc.). These are used internally by the SDK.

## Support

### Documentation
- [Telr Developer Portal](https://docs.telr.com)

### Contact Information
- **Email**: support@telr.com

### Community
- [GitHub Repository](https://github.com/Telr-PG/telr-sdk-ios)
- [Issue Tracker](https://github.com/Telr-PG/telr-sdk-ios/issues)

### Version Information
- **Current Version**: 4.1.1
- **Minimum iOS Version**: 15.1
- **Swift Version**: 6.0
- **Last Updated**: March 2026

---

<div align="center">
  <p><strong>Telr Mobile Payment SDK - iOS</strong></p>
  <p>Secure • Reliable • Easy to Integrate</p>
  <p>© 2025 Telr. All rights reserved.</p>
</div>
