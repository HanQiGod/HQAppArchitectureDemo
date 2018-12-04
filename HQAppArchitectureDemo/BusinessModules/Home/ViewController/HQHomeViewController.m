//
//  HQHomeViewController.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQHomeViewController.h"
#import "HQHomeView.h"
#import "HQHomeDataCenter.h"

@interface HQHomeViewController () <HQHomeViewDelegate>
@property (nonatomic, strong) HQHomeView *mainView;
@property (nonatomic, strong) HQHomeDataCenter *dataCenter;
@end

@implementation HQHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - YBHomeViewDelegate

- (void)homeView:(HQHomeView *)view requestHomeListWithPage:(NSInteger)page {
    @weakify(self);
    [self.dataCenter network_getHomeListWithPage:page success:^(NSArray<HQHomeListModel *> * _Nonnull dataArray) {
        @strongify(self);
        [self.mainView requestHomeListSuccessWithArray:dataArray];
    } failed:^{
        @strongify(self);
        [self.mainView requestHomeListFailed];
    }];
}

#pragma mark - getter

- (HQHomeView *)mainView {
    if (!_mainView) {
        _mainView = [HQHomeView new];
        _mainView.delegate = self;
    }
    return _mainView;
}

- (HQHomeDataCenter *)dataCenter {
    if (!_dataCenter) {
        _dataCenter = [HQHomeDataCenter new];
    }
    return _dataCenter;
}

@end

