//
//  NSSet+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSSet+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSSet (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    // - setWithObject:
    [self exchangeClassMethodForClass:self
                     originalSelector:@selector(setWithObject:)
                 withSwizzledSelector:@selector(eg_setWithObject:)];
}

#pragma mark - swizzledMethods

// - setWithObject:
+ (instancetype)eg_setWithObject:(id)object {
    id instance = nil;
    @try {
        instance = [self eg_setWithObject:object];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return instance;
    }
}

@end
