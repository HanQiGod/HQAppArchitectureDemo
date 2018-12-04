//
//  HQHomeView.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <UIKit/UIKit.h>
#import "HQHomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@class HQHomeView;

@protocol HQHomeViewDelegate <NSObject>

@required

- (void)homeView:(HQHomeView *)view requestHomeListWithPage:(NSInteger)page;

@end

@interface HQHomeView : UIView

@property (nonatomic, weak) id<HQHomeViewDelegate> delegate;

- (void)requestHomeListSuccessWithArray:(NSArray<HQHomeListModel *> *)array;

- (void)requestHomeListFailed;

@end

NS_ASSUME_NONNULL_END
