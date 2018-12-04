//
//  NSString+HQFontSize.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "NSString+HQFontSize.h"

@implementation NSString (HQFontSize)

- (CGSize)hq_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGSize)hq_sizeForFont:(UIFont *)font size:(CGSize)size {
    return [self hq_sizeForFont:font size:size mode:NSLineBreakByWordWrapping];
}

- (CGFloat)hq_heightForFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    return [self hq_sizeForFont:font size:CGSizeMake(maxWidth, CGFLOAT_MAX)].height;
}

- (CGFloat)hq_widthForFont:(UIFont *)font maxHeight:(CGFloat)maxHeight {
    return [self hq_sizeForFont:font size:CGSizeMake(CGFLOAT_MAX, maxHeight)].width;
}


@end
