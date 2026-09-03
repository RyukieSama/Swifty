# RyukieSwifty

[中文](README.md) | [English](README-EN.md)

[![CocoaPods](https://img.shields.io/cocoapods/v/RyukieSwifty.svg?style=flat-square)](https://cocoapods.org/pods/RyukieSwifty)
[![Platform](https://img.shields.io/cocoapods/p/RyukieSwifty.svg?style=flat-square)](https://cocoapods.org/pods/RyukieSwifty)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat-square)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/RyukieSwifty.svg?style=flat-square)](LICENSE)

A lightweight, modular collection of Swift utilities and extensions for writing cleaner, more expressive iOS code.

RyukieSwifty provides commonly used helpers for Foundation, UIKit, CloudKit, interface orientation, module routing, network service abstractions, and screen-capture protection. Install the complete library or select only the subspecs your project needs.

## Features

- **Modular installation** — include only the functionality your project needs
- **Foundation extensions** — convenient helpers for strings, dates, collections, `Codable`, and `UserDefaults`
- **UIKit utilities** — chainable view configuration, nib loading, modular lists, colors, images, and more
- **Orientation management** — control interface orientation through a consistent API
- **Screen-capture protection** — protect sensitive view content during screenshots and screen recordings
- **Lightweight abstractions** — protocol-based routing and networking APIs with no required third-party implementation

## Requirements

- Swift 5.0+
- iOS 10.0+
- ScreenShield: iOS 13.0+

## Installation

### CocoaPods

Add the complete library to your `Podfile`:

```ruby
pod 'RyukieSwifty'
```

Then run:

```bash
pod install
```

### Install individual subspecs

| Subspec | Description |
| --- | --- |
| `Core` | Namespace, shared definitions, and logging utilities |
| `Foundation` | Foundation extensions, formatting, and asynchronous utilities |
| `UIKit` | UIKit extensions, chainable configuration, and modular list components |
| `CloudKit` | Conversion utilities for `UIImage` and `CKAsset` |
| `FullScreen` | Full-screen and interface-orientation management |
| `Router` | Protocol-based module routing |
| `SwiftyServiceProtocol` | Network-library-agnostic service interfaces |
| `ScreenShield` | Screenshot and screen-recording protection |

For example, to install only the Foundation extensions:

```ruby
pod 'RyukieSwifty/Foundation'
```

Replace `Foundation` with any subspec name from the table to install another component.

## Usage

Import the library where needed:

```swift
import RyukieSwifty
```

### Interface orientation

First, return the library's supported orientations from your `AppDelegate`:

```swift
func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
) -> UIInterfaceOrientationMask {
    application.swifty.supportedInterfaceOrientations
}
```

Then manage full-screen state from your view controller:

```swift
final class VideoViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swifty.needFullScreen()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        swifty.exitFullScreen()
    }

    @IBAction private func toggleFullScreen(_ sender: UIButton) {
        sender.isSelected
            ? swifty.exitFullScreen()
            : swifty.enterFullScreen()
    }
}
```

### Screen-capture protection

`ScreenShieldView` supports iOS 13 and later. Add sensitive content to this view to hide it in screenshots and screen recordings.

![ScreenShield demo](ScreenShield.gif)

```swift
import UIKit
import RyukieSwifty

final class SecureViewController: UIViewController {
    override func loadView() {
        view = ScreenShieldView.create(frame: UIScreen.main.bounds)
    }
}
```

Objective-C:

```objc
@import RyukieSwifty;

- (void)loadView {
    self.view = [ScreenShieldView createWithFrame:UIScreen.mainScreen.bounds];
}
```

> Screen-capture protection relies on the system's secure text-input rendering behavior. It is automatically disabled on iOS 15.1 to avoid a known crash. Test it thoroughly on every OS version and device you support before shipping.

## Example project

Clone the repository, then run:

```bash
cd Example
pod install
open Swifty.xcworkspace
```

## Contributing

Bug reports and feature requests are welcome through [Issues](https://github.com/RyukieSama/Swifty/issues). Pull requests are also appreciated. Before submitting a change, please make sure the example project builds successfully.

## Author

RyukieSama · ryukie.sama@gmail.com

## License

RyukieSwifty is released under the MIT License. See [LICENSE](LICENSE) for details.
