//
//  NSAttributedString+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSAttributedString+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSAttributedString (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    Class class = NSClassFromString(@"NSConcreteAttributedString");
    
    // - initWithString:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(initWithString:)
                    withSwizzledSelector:@selector(eg_initWithString:)];
    
    // - attributedSubstringFromRange:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(attributedSubstringFromRange:)
                    withSwizzledSelector:@selector(eg_attributedSubstringFromRange:)];
}

#pragma mark - swizzledMethods

// - initWithString:
- (instancetype)eg_initWithString:(NSString *)str {
    id object = nil;
    @try {
        object = [self eg_initWithString:str];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - attributedSubstringFromRange:
- (NSAttributedString *)eg_attributedSubstringFromRange:(NSRange)range {
    id object = nil;
    @try {
        object = [self eg_attributedSubstringFromRange:range];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

@end
