//
//  NSMutableDictionary+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSMutableDictionary+SNExceptionGuarder.h"
#import "SNExceptionGuarder.h"

@implementation NSMutableDictionary (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        
        // - setObject:forKey:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(setObject:forKey:)
                        withSwizzledSelector:@selector(eg_setObject:forKey:)];
        
        // - removeObjectForKey:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(removeObjectForKey:)
                        withSwizzledSelector:@selector(eg_removeObjectForKey:)];
    });
}

#pragma mark - swizzledMethods

// - setObject:forKey:
- (void)eg_setObject:(id)anObject forKey:(id<NSCopying>)key {
    @try {
        [self eg_setObject:anObject forKey:key];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - removeObjectForKey:
- (void)eg_removeObjectForKey:(id)key {
    @try {
        [self eg_removeObjectForKey:key];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

@end
