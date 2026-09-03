# RyukieSwifty

[中文](README.md) | [English](README-EN.md)

[![CocoaPods](https://img.shields.io/cocoapods/v/RyukieSwifty.svg?style=flat-square)](https://cocoapods.org/pods/RyukieSwifty)
[![Platform](https://img.shields.io/cocoapods/p/RyukieSwifty.svg?style=flat-square)](https://cocoapods.org/pods/RyukieSwifty)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat-square)](https://swift.org)
[![License](https://img.shields.io/cocoapods/l/RyukieSwifty.svg?style=flat-square)](LICENSE)

一组轻量、模块化的 Swift 实用工具与扩展，让常见的 iOS 开发任务更简洁、更符合 Swift 的表达方式。

RyukieSwifty 涵盖 Foundation、UIKit、CloudKit、屏幕方向管理、模块路由、网络服务协议及截屏防护等常用能力。你可以安装完整组件，也可以只引入项目需要的子模块。

## 特性

- **模块化安装**：按需引入，避免不必要的依赖
- **常用类型扩展**：包含字符串、日期、集合、Codable、UserDefaults 等便捷能力
- **UIKit 工具集**：提供视图链式配置、Nib 加载、列表模块化、颜色及图片等扩展
- **横竖屏管理**：以统一 API 控制页面的屏幕方向
- **截屏防护**：在系统截屏或录屏时保护敏感视图内容
- **轻量协议抽象**：提供模块路由和网络服务接口，不绑定具体第三方实现

## 环境要求

- Swift 5.0+
- iOS 10.0+
- ScreenShield：iOS 13.0+

## 安装

### CocoaPods

在 `Podfile` 中添加完整组件：

```ruby
pod 'RyukieSwifty'
```

然后执行：

```bash
pod install
```

### 按需安装

| 子模块 | 说明 |
| --- | --- |
| `Core` | 命名空间、基础定义及日志工具 |
| `Foundation` | Foundation 类型扩展、格式化及异步工具 |
| `UIKit` | UIKit 组件扩展、链式配置及列表模块化能力 |
| `CloudKit` | `UIImage` 与 `CKAsset` 转换工具 |
| `FullScreen` | 横竖屏与全屏方向管理 |
| `Router` | 基于协议的模块路由 |
| `SwiftyServiceProtocol` | 与具体网络库无关的服务接口协议 |
| `ScreenShield` | 截屏与录屏内容防护 |

例如，只安装 Foundation 扩展：

```ruby
pod 'RyukieSwifty/Foundation'
```

将 `Foundation` 替换为表格中的其他子模块名称，即可按需安装相应功能。

## 使用方式

安装后，在需要使用的文件中导入模块：

```swift
import RyukieSwifty
```

### 横竖屏切换

首先在 `AppDelegate` 中返回组件当前支持的屏幕方向：

```swift
func application(
    _ application: UIApplication,
    supportedInterfaceOrientationsFor window: UIWindow?
) -> UIInterfaceOrientationMask {
    application.swifty.supportedInterfaceOrientations
}
```

然后在视图控制器中管理全屏状态：

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

### 截屏防护

`ScreenShieldView` 适用于 iOS 13 及以上系统。将需要保护的内容添加到该视图中，即可在截屏或录屏时隐藏内容。

![ScreenShield 演示](ScreenShield.gif)

```swift
import UIKit
import RyukieSwifty

final class SecureViewController: UIViewController {
    override func loadView() {
        view = ScreenShieldView.create(frame: UIScreen.main.bounds)
    }
}
```

Objective-C：

```objc
@import RyukieSwifty;

- (void)loadView {
    self.view = [ScreenShieldView createWithFrame:UIScreen.mainScreen.bounds];
}
```

> 截屏防护依赖系统内部的安全输入渲染机制。为规避已知崩溃，该能力在 iOS 15.1 上会自动停用。正式使用前，请在目标系统版本和设备上充分测试。

## 示例项目

克隆仓库后，在项目根目录执行：

```bash
cd Example
pod install
open Swifty.xcworkspace
```

## 参与贡献

欢迎通过 [Issues](https://github.com/RyukieSama/Swifty/issues) 报告问题或提出建议，也欢迎提交 Pull Request。提交改动前，请确保示例项目能够正常构建。

## 作者

RyukieSama · ryukie.sama@gmail.com

## 许可证

RyukieSwifty 基于 MIT 许可证发布，详情请参阅 [LICENSE](LICENSE)。
