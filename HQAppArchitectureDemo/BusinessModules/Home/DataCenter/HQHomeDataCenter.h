//
//  HQHomeDataCenter.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>
#import "HQHomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HQHomeDataCenter : NSObject

//这里也可以用代理回调网络请求
- (void)network_getHomeListWithPage:(NSInteger)page success:(void(^)(NSArray<HQHomeListModel *> *dataArray))success failed:(void(^)(void))failed;

@end

NS_ASSUME_NONNULL_END
