//
//  HQRootTabBarViewController.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQRootTabBarViewController.h"
#import "HQNaviagtionViewController.h"
#import "HQHomeViewController.h"
#import "HQTrendsViewController.h"
#import "HQMineViewController.h"

@interface HQRootTabBarViewController ()

@property (nonatomic, strong) HQHomeViewController *homeVC;
@property (nonatomic, strong) HQTrendsViewController *trendsVC;
@property (nonatomic, strong) HQMineViewController *mineVC;

@end

@implementation HQRootTabBarViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.shadowImage = [UIImage new];
    
    [self configSubViewControllers];
}

#pragma mark - private

- (void)configSubViewControllers {
    self.viewControllers = @[[self getViewControllerWithVC:self.homeVC title:@"主页" normalImage:[UIImage new] selectImage:[UIImage new]],
                             [self getViewControllerWithVC:self.trendsVC title:@"动态" normalImage:[UIImage new] selectImage:[UIImage new]],
                             [self getViewControllerWithVC:self.mineVC title:@"我的" normalImage:[UIImage new] selectImage:[UIImage new]]];
}

- (UIViewController *)getViewControllerWithVC:(UIViewController *)vc title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage {
    
    vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HQGeneralColor.tabBarTitleSelectedColor} forState:UIControlStateSelected];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HQGeneralColor.tabBarTitleNormalColor} forState:UIControlStateNormal];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    vc.navigationItem.title = title;
    HQNaviagtionViewController *nav = [[HQNaviagtionViewController alloc] initWithRootViewController:vc];
    return nav;
}

#pragma mark - getter

- (HQHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC = [HQHomeViewController new];
    }
    return _homeVC;
}

- (HQTrendsViewController *)trendsVC {
    if (!_trendsVC) {
        _trendsVC = [HQTrendsViewController new];
    }
    return _trendsVC;
}

- (HQMineViewController *)mineVC {
    if (!_mineVC) {
        _mineVC = [HQMineViewController new];
    }
    return _mineVC;
}

@end
