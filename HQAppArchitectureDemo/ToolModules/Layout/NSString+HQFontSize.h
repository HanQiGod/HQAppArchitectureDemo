//
//  NSString+HQFontSize.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HQFontSize)

- (CGSize)hq_sizeForFont:(UIFont *)font size:(CGSize)size;
- (CGSize)hq_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
- (CGFloat)hq_heightForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
- (CGFloat)hq_widthForFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

@end

NS_ASSUME_NONNULL_END
