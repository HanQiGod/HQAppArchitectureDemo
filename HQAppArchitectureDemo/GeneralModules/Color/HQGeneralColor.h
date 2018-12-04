//
//  HQGeneralColor.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQGeneralColor : NSObject

/** 主题色 */
+ (UIColor *)themeColor;

/** 导航栏颜色 */
+ (UIColor *)navigationBarColor;

/** 导航栏标题颜色 */
+ (UIColor *)navigationBarTitleColor;

/** 标签栏标题选中颜色 */
+ (UIColor *)tabBarTitleSelectedColor;

/** 标签栏标题正常颜色 */
+ (UIColor *)tabBarTitleNormalColor;

/** 分割线的颜色 */
+ (UIColor *)seperaterColor;

@end

NS_ASSUME_NONNULL_END
