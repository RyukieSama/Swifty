# Swifty - Make swift code swifty

[![CI Status](https://img.shields.io/travis/RyukieSama/RyukieSwifty.svg?style=flat)](https://travis-ci.org/RyukieSama/RyukieSwifty)
[![Version](https://img.shields.io/cocoapods/v/RyukieSwifty.svg?style=flat)](https://cocoapods.org/pods/RyukieSwifty)
[![License](https://img.shields.io/cocoapods/l/RyukieSwifty.svg?style=flat)](https://cocoapods.org/pods/RyukieSwifty)
[![Platform](https://img.shields.io/cocoapods/p/Swifty.svg?style=flat)](https://cocoapods.org/pods/RyukieSwifty)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Swifty is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

## All install - 安装全部

```ruby
pod 'RyukieSwifty'
```

## Subspec install - 子模块安装

### UIKit Extension

```ruby
pod 'RyukieSwifty/UIKit'
```

### CloudKit Extension

```ruby
pod 'RyukieSwifty/CloudKit'
```

### Foundation Extension

```ruby
pod 'RyukieSwifty/Foundation'
```

### FullScreen Extension

```ruby
pod 'RyukieSwifty/FullScreen'
```

### Router Protocol

```ruby
pod 'RyukieSwifty/Router'
```

### Service Protocol - MoyaStyleProtocol

混编项目（AFN）或者自定义网络库，通过该协议可以使 `Swift` 内容中的网络请求实现有 `Moya` 的风格，更加 `Swifty`

```ruby
pod 'RyukieSwifty/SwiftyServiceProtocol'
```

### ScreenShield - 截屏防护

极其轻量化的截屏防护方案，任何需要被保护的 `View` 作为子视图放入 `ScreenShieldView` 即可达到截屏时隐藏内容的效果。

![ScreenShield](ScreenShield.gif)

```ruby
pod 'RyukieSwifty/ScreenShield'
```

Swift - Demo: 

```Swift
import UIKit
import RyukieSwifty

class ViewController: UIViewController {
    override func loadView() {
        view = ScreenShieldView.create()
    }
    ...
}
```

OC - Demo:

```C++
#import "OCScreenShieldViewController.h"
@import RyukieSwifty;

@interface OCScreenShieldViewController ()

@end

@implementation OCScreenShieldViewController

- (void)loadView {
    self.view = [ScreenShieldView createWithFrame:UIScreen.mainScreen.bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *cubeView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    cubeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cubeView];
    
    self.view.backgroundColor = [UIColor grayColor];
}

@end
```

## Author

RyukieSama, ryukie.sama@gmail.com

## License

Swifty is available under the MIT license. See the LICENSE file for more info.


