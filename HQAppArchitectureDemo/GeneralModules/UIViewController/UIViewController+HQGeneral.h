//
//  UIViewController+HQGeneral.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HQGeneral)

/** 基础配置 */
- (void)HQGeneral_baseConfig;

@end

@interface UIViewController (HQGeneralBackItem)

/** 配置通用系统导航栏返回按钮 */
- (void)HQGeneral_configBackItem;

/** 重写该方法以自定义系统导航栏返回按钮点击事件 */
- (void)HQGeneral_clickBackItem:(UIBarButtonItem *)item;

@end

NS_ASSUME_NONNULL_END
