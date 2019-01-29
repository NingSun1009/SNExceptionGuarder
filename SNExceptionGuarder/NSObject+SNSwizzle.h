//
//  NSObject+Swizzle.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzle)

/**
 交换类方法

 @param class 目标类
 @param originalSelector 被交换的selector
 @param swizzledSelector 新的selector
 */
+ (void)exchangeClassMethodForClass:(Class)class
                   originalSelector:(SEL)originalSelector
               withSwizzledSelector:(SEL)swizzledSelector;

/**
 交换实例方法

 @param class 目标类
 @param originalSelector 被交换的selector
 @param swizzledSelector 新的selector
 */
+ (void)exchangeInstanceMethodForClass:(Class)class
                      originalSelector:(SEL)originalSelector
                  withSwizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
