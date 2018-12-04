//
//  NSString+HQCodec.h
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HQCodec)

- (NSString *)hq_encodingUTF8;

- (NSString *)hq_MD5;

@end

NS_ASSUME_NONNULL_END
