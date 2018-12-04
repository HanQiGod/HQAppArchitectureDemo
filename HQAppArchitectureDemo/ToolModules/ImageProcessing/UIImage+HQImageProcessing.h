//
//  UIImage+HQImageProcessing.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HQImageProcessing)

/**
 根据颜色生成图片
 
 @param color 颜色
 @return --
 */
+ (UIImage *)yb_imageWithColor:(UIColor *)color;

/**
 根据颜色生成图片
 
 @param color 颜色
 @param rect 大小
 @return --
 */
+ (UIImage *)yb_imageWithColor:(UIColor *)color rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
