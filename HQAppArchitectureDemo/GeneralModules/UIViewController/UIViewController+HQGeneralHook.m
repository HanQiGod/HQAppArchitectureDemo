//
//  UIViewController+HQGeneralHook.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "UIViewController+HQGeneralHook.h"
#import "UIViewController+HQGeneral.h"
#import <objc/runtime.h>

@implementation UIViewController (HQGeneralHook)

+ (void)load {
    [self HQGeneralHook_exchangeImplementationsWithOriginSel:@selector(viewDidLoad) customSel:@selector(YBGeneralHook_viewDidLoad)];
}

+ (void)HQGeneralHook_exchangeImplementationsWithOriginSel:(SEL)originSel customSel:(SEL)customSel {
    Method origin = class_getInstanceMethod(self, originSel);
    Method custom = class_getInstanceMethod(self, customSel);
    if (origin && custom) {
        method_exchangeImplementations(origin, custom);
    }
}

- (void)HQGeneralHook_viewDidLoad {
    NSLog(@"进入：%@", self);
    [self HQGeneral_baseConfig];
    if (self.navigationController && [self.navigationController.viewControllers indexOfObject:self] != 0) {
        [self HQGeneral_configBackItem];
    }
    
    [self HQGeneralHook_viewDidLoad];
}


@end

