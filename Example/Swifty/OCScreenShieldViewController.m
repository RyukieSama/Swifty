//
//  OCScreenShieldViewController.m
//  Swifty_Example
//
//  Created by 王荣庆 on 2022/2/25.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

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
