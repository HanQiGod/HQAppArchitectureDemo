//
//  HQSystemTool.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQSystemTool : NSObject

/** 判断是否是 iphoneX 系列 */
+ (BOOL)isIphoneX;

/** app 版本号 */
+ (NSString *)appVersion;

/** app 名称 */
+ (NSString *)appName;

@end

@interface HQSystemTool (UI)

/** 获取顶层的 UIViewController 实例 */
+ (UIViewController *)topViewController;

/** 获取 windowLevel 为 UIWindowLevelNormal 的 UIWindow 实例 */
+ (UIWindow *)normalWindow;

@end

NS_ASSUME_NONNULL_END
