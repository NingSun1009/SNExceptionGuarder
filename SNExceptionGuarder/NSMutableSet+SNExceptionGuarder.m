//
//  NSMutableSet+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSMutableSet+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSMutableSet (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    Class class = NSClassFromString(@"__NSSetM");
    
    // - addObject:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(addObject:)
                    withSwizzledSelector:@selector(eg_addObject:)];
    
    // - removeObject:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(removeObject:)
                    withSwizzledSelector:@selector(eg_removeObject:)];
}

#pragma mark - swizzledMethods

// - addObject:
- (void)eg_addObject:(id)object{
    @try {
        [self eg_addObject:object];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeObject:
- (void)eg_removeObject:(id)object {
    @try {
        [self eg_removeObject:object];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

@end
