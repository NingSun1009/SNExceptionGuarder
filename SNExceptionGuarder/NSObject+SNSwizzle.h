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
 Swap class method.

 @param class The target class.
 @param originalSelector Selector that is swapped.
 @param swizzledSelector The new selector.
 */
+ (void)exchangeClassMethodForClass:(Class)class
                   originalSelector:(SEL)originalSelector
               withSwizzledSelector:(SEL)swizzledSelector;

/**
 Swap instance method.

 @param class The target class.
 @param originalSelector Selector that is swapped.
 @param swizzledSelector The new selector.
 */
+ (void)exchangeInstanceMethodForClass:(Class)class
                      originalSelector:(SEL)originalSelector
                  withSwizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
