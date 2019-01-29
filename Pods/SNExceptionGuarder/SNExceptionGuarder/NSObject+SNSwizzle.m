//
//  NSObject+Swizzle.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSObject+SNSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (SNSwizzle)

+ (void)exchangeClassMethodForClass:(Class)class
                   originalSelector:(SEL)originalSelector
               withSwizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+ (void)exchangeInstanceMethodForClass:(Class)class
                      originalSelector:(SEL)originalSelector
                  withSwizzledSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
