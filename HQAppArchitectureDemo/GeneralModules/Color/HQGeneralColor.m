//
//  HQGeneralColor.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQGeneralColor.h"

@implementation HQGeneralColor

+ (UIColor *)themeColor {
    return [UIColor orangeColor];
}

+ (UIColor *)navigationBarColor {
    return [UIColor orangeColor];
}

+ (UIColor *)navigationBarTitleColor {
    return [UIColor darkTextColor];
}

+ (UIColor *)tabBarTitleNormalColor {
    return [UIColor darkGrayColor];
}

+ (UIColor *)tabBarTitleSelectedColor {
    return [UIColor orangeColor];
}

+ (UIColor *)seperaterColor {
    return [UIColor groupTableViewBackgroundColor];
}


@end
