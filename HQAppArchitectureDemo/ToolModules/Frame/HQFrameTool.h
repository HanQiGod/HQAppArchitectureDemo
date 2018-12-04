//
//  HQFrameTool.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HQFrameTool : NSObject

/** iphone 底部额外的高度 */
+ (CGFloat)iphoneBottomHeight;

/** 标签栏高度 */
+ (CGFloat)tabBarHeight;

/** 状态栏高度 */
+ (CGFloat)statusBarHeight;

/** 导航栏高度 */
+ (CGFloat)navigationBarHeight;

@end

NS_ASSUME_NONNULL_END
