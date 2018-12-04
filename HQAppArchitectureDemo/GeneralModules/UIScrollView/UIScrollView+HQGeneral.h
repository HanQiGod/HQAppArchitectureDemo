//
//  UIScrollView+HQGeneral.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HQGeneral)

- (void)HQGeneral_addRefreshHeader:(void(^)(void))block;
- (void)HQGeneral_addRefreshFooter:(void(^)(void))block;
- (void)HQGeneral_addRefreshHeader:(void(^)(void))blockH footer:(void(^)(void))blockF;


@end

NS_ASSUME_NONNULL_END
