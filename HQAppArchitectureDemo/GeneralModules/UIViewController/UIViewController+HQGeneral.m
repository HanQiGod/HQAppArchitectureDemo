//
//  UIViewController+HQGeneral.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "UIViewController+HQGeneral.h"

@implementation UIViewController (HQGeneral)

- (void)HQGeneral_baseConfig {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end

@implementation UIViewController (HQGeneralBackItem)

- (void)HQGeneral_configBackItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(HQGeneral_clickBackItem:)];
    backItem.image = [[UIImage imageNamed:@"btn_back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)HQGeneral_clickBackItem:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
