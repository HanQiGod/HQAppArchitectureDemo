//
//  UIScrollView+HQGeneral.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "UIScrollView+HQGeneral.h"

@implementation UIScrollView (HQGeneral)

- (void)HQGeneral_addRefreshHeader:(void (^)(void))blockH footer:(void (^)(void))blockF {
    @weakify(self);
    [self HQGeneral_addRefreshHeader:^{
        if (blockH) blockH();
    } endRefresh:^{
        @strongify(self);
        if (!self.mj_footer) {
            [self HQGeneral_addRefreshFooter:^{
                if (blockF) blockF();
            }];
        }
    }];
}

- (void)HQGeneral_addRefreshHeader:(void (^)(void))block {
    [self HQGeneral_addRefreshHeader:block endRefresh:nil];
}

- (void)HQGeneral_addRefreshHeader:(void (^)(void))block endRefresh:(void (^)(void))endRefresh {
    
    @weakify(self);
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        BOOL isRefresh = self.mj_footer.state == MJRefreshStateRefreshing || self.mj_footer.state == MJRefreshStateWillRefresh || self.mj_footer.state == MJRefreshStatePulling;
        if (isRefresh) {
            [self.mj_header endRefreshing];
            return;
        }
        if (block) block();
    }];
    [refreshHeader setEndRefreshingCompletionBlock:^{
        if (endRefresh) endRefresh();
    }];
    
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.font = [UIFont systemFontOfSize:12];
    refreshHeader.stateLabel.textColor = [UIColor lightGrayColor];
    
    self.mj_header = refreshHeader;
}

- (void)HQGeneral_addRefreshFooter:(void (^)(void))block {
    
    @weakify(self);
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        BOOL isRefresh = self.mj_header.state == MJRefreshStateRefreshing || self.mj_header.state == MJRefreshStateWillRefresh || self.mj_header.state == MJRefreshStatePulling;
        if (isRefresh) {
            [self.mj_footer endRefreshing];
            return;
        }
        if (block) block();
    }];
    
    refreshFooter.automaticallyChangeAlpha = YES;
    refreshFooter.stateLabel.font = [UIFont systemFontOfSize:12];
    refreshFooter.stateLabel.textColor = [UIColor lightGrayColor];
    [refreshFooter setTitle:@"别扯了，已经到底了~" forState:MJRefreshStateNoMoreData];
    
    self.mj_footer = refreshFooter;
}


@end
