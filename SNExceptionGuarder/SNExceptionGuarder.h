//
//  SNExceptionGuarder.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SNExceptionGuarderProxy.h"

#import "NSObject+SNSwizzle.h"
#import "NSObject+SNExceptionGuarder.h"

#import "NSArray+SNExceptionGuarder.h"
#import "NSMutableArray+SNExceptionGuarder.h"

#import "NSDictionary+SNExceptionGuarder.h"
#import "NSMutableArray+SNExceptionGuarder.h"

#import "NSString+SNExceptionGuarder.h"
#import "NSMutableString+SNExceptionGuarder.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SNExceptionGuarderBlock)(NSDictionary* params);

@interface SNExceptionGuarder : NSObject

@property (nonatomic, copy) SNExceptionGuarderBlock block;

+ (instancetype)shareInstance;

/**
 开启crash守护
 */
- (void)startWithBlock:(SNExceptionGuarderBlock)block;

/**
 *  提示崩溃的信息(控制台输出、通知)
 *
 *  @param exception   捕获到的异常
 *  @param defaultOP 这个框架里默认的做法
 */
- (void)noteErrorWithException:(NSException *)exception defaultOP:(NSString *)defaultOP;

@end

NS_ASSUME_NONNULL_END
