//
//  HQHomeDataCenter.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQHomeDataCenter.h"

@implementation HQHomeDataCenter

- (void)network_getHomeListWithPage:(NSInteger)page success:(void (^)(NSArray<HQHomeListModel *> * _Nonnull))success failed:(void (^)(void))failed {
    
    //模拟网络请求
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (success) {
                if (page >= 5) {
                    success(@[]);
                    return;
                }
                
                NSArray *data = @[@{@"name":@"蒙奇·D·路飞", @"motto":@"外号“草帽”路飞，草帽海贼团、草帽大船团船长，极恶的世代之一。橡胶果实能力者，悬赏金15亿贝里。梦想是找到传说中的One Piece，成为海贼王。路飞性格积极乐观，爱憎分明，而且十分重视伙伴，不甘屈居于他人之下，对任何危险的事物都超感兴趣。和其他传统的海贼所不同的是，他并不会为了追求财富而杀戮，而是享受着身为海贼的冒险和自由。"},
                                  @{@"name":@"罗罗诺亚·索隆", @"motto":@"草帽一伙的战斗员，是使用三把刀战斗的三刀流剑士。两年前集结香波地群岛的被称之为“极恶的世代”的十一超新星之一，在超新星中赏金排名第十位。"},
                                  @{@"name":@"娜美", @"motto":@"草帽一伙的航海士，人称小贼猫，悬赏6600万贝里。特征是橘色的短发（两年后为波浪长发）和左肩的刺青（风车与橘子的图案）。使用棍术，现在武器为“魔法天候棒”。头脑聪明又机灵，精通气象学和航海术，能用身体感知天气，完美指示航路，是个能精确画出航海图的天才航海士。本质上是个细心、善良、重视感情、嫉恶如仇、偶尔有些温柔的能干的女性。最喜欢钱和橘子，梦想是要画出全世界的地图。"}];
                NSMutableArray *result = [NSMutableArray array];
                for (NSDictionary *dic in data) {
                    HQHomeListModel *model = [HQHomeListModel new];
                    model.name = dic[@"name"];
                    model.motto = dic[@"motto"];
                    [result addObject:model];
                }
                success(result);
            }
        });
    });
}

@end
