//
//  NSDictionary+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSDictionary+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSDictionary (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
    // - initWithObjects:forKeys:count:
    [self exchangeInstanceMethodForClass:__NSPlaceholderDictionary
                        originalSelector:@selector(initWithObjects:forKeys:count:)
                    withSwizzledSelector:@selector(eg_initWithObjects:forKeys:count:)];
}

#pragma mark - swizzledMethods

// - initWithObjects:forKeys:count:
- (instancetype)eg_initWithObjects:(const id _Nonnull [_Nullable])objects
                           forKeys:(const id <NSCopying> _Nonnull [_Nullable])keys
                             count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self eg_initWithObjects:objects
                                    forKeys:keys
                                      count:cnt];
    } @catch (NSException *exception) {
        NSString *msg = @"SNExceptionGuarder remove nil key-values and instance a dictionary.";
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:msg];
    } @finally {
        return instance;
    }
}

@end
