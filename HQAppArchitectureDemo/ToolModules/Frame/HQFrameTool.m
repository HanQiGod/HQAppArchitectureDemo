//
//  HQFrameTool.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQFrameTool.h"
#import "HQSystemTool.h"

@implementation HQFrameTool

+ (CGFloat)iphoneBottomHeight {
    return HQSystemTool.isIphoneX ? 34.0 : 0.0;
}

+ (CGFloat)tabBarHeight {
    return [self iphoneBottomHeight] + 49.0;
}

+ (CGFloat)statusBarHeight {
    return HQSystemTool.isIphoneX ? 44.0 : 20.0;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

@end

