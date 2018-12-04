//
//  HQNaviagtionViewController.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQNaviagtionViewController.h"

@interface HQNaviagtionViewController ()

@end

@implementation HQNaviagtionViewController

#pragma mark - life cycle

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        [self configNavigationBar];
    }
    return self;
}

#pragma mark - private

- (void)configNavigationBar {
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = HQGeneralColor.navigationBarColor;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HQGeneralColor.navigationBarTitleColor, NSFontAttributeName:HQGeneralFont.navigationBarTitleFont}];
}

#pragma mark - overwrite

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
