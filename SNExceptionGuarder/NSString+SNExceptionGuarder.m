//
//  NSString+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSString+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSString (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    // for Class
    // + stringWithUTF8String:
    [self exchangeClassMethodForClass:[NSString class]
                     originalSelector:@selector(stringWithUTF8String:)
                 withSwizzledSelector:@selector(eg_stringWithUTF8String:)];
    
    // + stringWithCString:encoding:
    [self exchangeClassMethodForClass:[NSString class]
                     originalSelector:@selector(stringWithCString:encoding:)
                 withSwizzledSelector:@selector(eg_stringWithCString:encoding:)];
    
    Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
    Class NSTaggedPointerString = NSClassFromString(@"NSTaggedPointerString");
    Class NSPlaceholderString = NSClassFromString(@"NSPlaceholderString");
    
    // for Instance
    // - characterAtIndex:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(characterAtIndex:)
                    withSwizzledSelector:@selector(eg_cf_characterAtIndex:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(characterAtIndex:)
                    withSwizzledSelector:@selector(eg_tp_characterAtIndex:)];
    
    // - substringFromIndex:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(substringFromIndex:)
                    withSwizzledSelector:@selector(eg_cf_substringFromIndex:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(substringFromIndex:)
                    withSwizzledSelector:@selector(eg_tp_substringFromIndex:)];
    
    // - substringToIndex:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(substringToIndex:)
                    withSwizzledSelector:@selector(eg_cf_substringToIndex:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(substringToIndex:)
                    withSwizzledSelector:@selector(eg_tp_substringToIndex:)];
    
    // - substringWithRange:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(substringWithRange:)
                    withSwizzledSelector:@selector(eg_cf_substringWithRange:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(substringWithRange:)
                    withSwizzledSelector:@selector(eg_tp_substringWithRange:)];
    
    // - stringByReplacingOccurrencesOfString:withString:options:range:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(stringByReplacingOccurrencesOfString:
                                                   withString:options:range:)
                    withSwizzledSelector:@selector(eg_cf_stringByReplacingOccurrencesOfString:
                                                   withString:options:range:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(stringByReplacingOccurrencesOfString:
                                                   withString:
                                                   options:
                                                   range:)
                    withSwizzledSelector:@selector(eg_tp_stringByReplacingOccurrencesOfString:
                                                   withString:
                                                   options:
                                                   range:)];
    
    // - stringByReplacingCharactersInRange:withString:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(stringByReplacingCharactersInRange:
                                                   withString:)
                    withSwizzledSelector:@selector(eg_cf_stringByReplacingCharactersInRange:
                                                   withString:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(stringByReplacingCharactersInRange:
                                                   withString:)
                    withSwizzledSelector:@selector(eg_tp_stringByReplacingCharactersInRange:
                                                   withString:)];
    
    // - rangeOfString:options:range:locale:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(rangeOfString:options:range:locale:)
                    withSwizzledSelector:@selector(eg_cf_rangeOfString:options:range:locale:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(rangeOfString:options:range:locale:)
                    withSwizzledSelector:@selector(eg_tp_rangeOfString:options:range:locale:)];
    
    // - stringByAppendingString:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(stringByAppendingString:)
                    withSwizzledSelector:@selector(eg_cf_stringByAppendingString:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(stringByAppendingString:)
                    withSwizzledSelector:@selector(eg_tp_stringByAppendingString:)];
    
    // - initWithUTF8String:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(initWithUTF8String:)
                    withSwizzledSelector:@selector(eg_cf_initWithUTF8String:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(initWithUTF8String:)
                    withSwizzledSelector:@selector(eg_tp_initWithUTF8String:)];
    
    // - initWithFormat:locale:arguments:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(initWithFormat:locale:arguments:)
                    withSwizzledSelector:@selector(eg_cf_initWithFormat:locale:arguments:)];
    
    [self exchangeInstanceMethodForClass:NSPlaceholderString
                        originalSelector:@selector(initWithFormat:locale:arguments:)
                    withSwizzledSelector:@selector(eg_ph_initWithFormat:locale:arguments:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(initWithFormat:locale:arguments:)
                    withSwizzledSelector:@selector(eg_tp_initWithFormat:locale:arguments:)];
    
    // - initWithCharactersNoCopy:length:freeWhenDone:
    [self exchangeInstanceMethodForClass:__NSCFConstantString
                        originalSelector:@selector(initWithCharactersNoCopy:length:freeWhenDone:)
                    withSwizzledSelector:@selector(eg_cf_initWithCharactersNoCopy:length:freeWhenDone:)];
    
    [self exchangeInstanceMethodForClass:NSPlaceholderString
                        originalSelector:@selector(initWithCharactersNoCopy:length:freeWhenDone:)
                    withSwizzledSelector:@selector(eg_ph_initWithCharactersNoCopy:length:freeWhenDone:)];
    
    [self exchangeInstanceMethodForClass:NSTaggedPointerString
                        originalSelector:@selector(initWithCharactersNoCopy:length:freeWhenDone:)
                    withSwizzledSelector:@selector(eg_tp_initWithCharactersNoCopy:length:freeWhenDone:)];
    
    // - initWithString:
    [self exchangeInstanceMethodForClass:NSPlaceholderString
                        originalSelector:@selector(initWithString:)
                    withSwizzledSelector:@selector(eg_initWithString:)];
}

#pragma mark - swizzledMethods

// + stringWithUTF8String:
+ (nullable instancetype)eg_stringWithUTF8String:(const char *)nullTerminatedCString; {
    NSString *subString = nil;
    @try {
        subString = [self eg_stringWithUTF8String:nullTerminatedCString];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// + stringWithCString:encoding:
+ (nullable instancetype)eg_stringWithCString:(const char *)cString
                                     encoding:(NSStringEncoding)enc {
    NSString *subString = nil;
    @try {
        subString = [self eg_stringWithCString:cString encoding:enc];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - characterAtIndex:
- (unichar)eg_cf_characterAtIndex:(NSUInteger)index {
    unichar characteristic;
    @try {
        characteristic = [self eg_cf_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *msg = @"SNExceptionGuarder return a without assign unichar.";
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:msg];
    }
    @finally {
        return characteristic;
    }
}

- (unichar)eg_tp_characterAtIndex:(NSUInteger)index {
    unichar characteristic;
    @try {
        characteristic = [self eg_tp_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *msg = @"SNExceptionGuarder return a without assign unichar.";
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:msg];
    }
    @finally {
        return characteristic;
    }
}

// - substringFromIndex:
- (instancetype)eg_cf_substringFromIndex:(NSUInteger)index {
    NSString *subString = nil;
    @try {
        subString = [self eg_cf_substringFromIndex:index];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

- (instancetype)eg_tp_substringFromIndex:(NSUInteger)index {
    NSString *subString = nil;
    @try {
        subString = [self eg_tp_substringFromIndex:index];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - substringToIndex:
- (instancetype)eg_cf_substringToIndex:(NSUInteger)index {
    NSString *subString = nil;
    @try {
        subString = [self eg_cf_substringToIndex:index];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

- (instancetype)eg_tp_substringToIndex:(NSUInteger)index {
    NSString *subString = nil;
    @try {
        subString = [self eg_tp_substringToIndex:index];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - substringWithRange:
- (instancetype)eg_cf_substringWithRange:(NSRange)range {
    NSString *subString = nil;
    @try {
        subString = [self eg_cf_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

- (instancetype)eg_tp_substringWithRange:(NSRange)range {
    NSString *subString = nil;
    @try {
        subString = [self eg_tp_substringWithRange:range];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - stringByReplacingOccurrencesOfString:withString:options:range:
- (instancetype)eg_cf_stringByReplacingOccurrencesOfString:(NSString *)targetStr
                                           withString:(NSString *)replaceStr
                                              options:(NSStringCompareOptions)options
                                                range:(NSRange)searchRange {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_stringByReplacingOccurrencesOfString:targetStr
                                                       withString:replaceStr
                                                          options:options
                                                            range:searchRange];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_tp_stringByReplacingOccurrencesOfString:(NSString *)targetStr
                                                withString:(NSString *)replaceStr
                                                   options:(NSStringCompareOptions)options
                                                     range:(NSRange)searchRange {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_stringByReplacingOccurrencesOfString:targetStr
                                                       withString:replaceStr
                                                          options:options
                                                            range:searchRange];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - stringByReplacingCharactersInRange:withString:
- (instancetype)eg_cf_stringByReplacingCharactersInRange:(NSRange)range
                                              withString:(NSString *)replaceStr {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_stringByReplacingCharactersInRange:range
                                                     withString:replaceStr];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_tp_stringByReplacingCharactersInRange:(NSRange)range
                                              withString:(NSString *)replaceStr {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_stringByReplacingCharactersInRange:range
                                                     withString:replaceStr];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - rangeOfString:options:range:locale:
- (NSRange)eg_cf_rangeOfString:(NSString *)searchString
                       options:(NSStringCompareOptions)mask
                         range:(NSRange)rangeOfReceiverToSearch
                        locale:(nullable NSLocale *)locale {
    NSRange range;
    @try {
        range = [self eg_cf_rangeOfString:searchString
                                  options:mask
                                    range:rangeOfReceiverToSearch
                                   locale:locale];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return range;
    }
}

- (NSRange)eg_tp_rangeOfString:(NSString *)searchString
                       options:(NSStringCompareOptions)mask
                         range:(NSRange)rangeOfReceiverToSearch
                        locale:(nullable NSLocale *)locale {
    NSRange range;
    @try {
        range = [self eg_tp_rangeOfString:searchString
                                  options:mask
                                    range:rangeOfReceiverToSearch
                                   locale:locale];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return range;
    }
}

// - stringByAppendingString:
- (instancetype)eg_cf_stringByAppendingString:(NSString *)aString {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_stringByAppendingString:aString];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_tp_stringByAppendingString:(NSString *)aString {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_stringByAppendingString:aString];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithUTF8String:
- (nullable instancetype)eg_cf_initWithUTF8String:(const char *)nullTerminatedCString {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_initWithUTF8String:nullTerminatedCString];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (nullable instancetype)eg_tp_initWithUTF8String:(const char *)nullTerminatedCString {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_initWithUTF8String:nullTerminatedCString];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithFormat:locale:arguments:
- (instancetype)eg_cf_initWithFormat:(NSString *)format
                              locale:(nullable id)locale
                           arguments:(va_list)argList {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_initWithFormat:format
                                     locale:locale
                                  arguments:argList];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_ph_initWithFormat:(NSString *)format
                              locale:(nullable id)locale
                           arguments:(va_list)argList {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_ph_initWithFormat:format
                                     locale:locale
                                  arguments:argList];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_tp_initWithFormat:(NSString *)format
                              locale:(nullable id)locale
                           arguments:(va_list)argList {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_initWithFormat:format
                                     locale:locale
                                  arguments:argList];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithCharactersNoCopy:length:freeWhenDone:
- (instancetype)eg_cf_initWithCharactersNoCopy:(unichar *)characters
                                        length:(NSUInteger)length
                                  freeWhenDone:(BOOL)freeBuffer {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_cf_initWithCharactersNoCopy:characters
                                               length:length
                                         freeWhenDone:freeBuffer];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_ph_initWithCharactersNoCopy:(unichar *)characters
                                        length:(NSUInteger)length
                                  freeWhenDone:(BOOL)freeBuffer {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_ph_initWithCharactersNoCopy:characters
                                               length:length
                                         freeWhenDone:freeBuffer];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

- (instancetype)eg_tp_initWithCharactersNoCopy:(unichar *)characters
                                        length:(NSUInteger)length
                                  freeWhenDone:(BOOL)freeBuffer {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_tp_initWithCharactersNoCopy:characters
                                               length:length
                                         freeWhenDone:freeBuffer];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithString:
- (instancetype)eg_initWithString:(NSString *)str {
    NSString *newStr = nil;
    @try {
        newStr = [self eg_initWithString:str];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

@end
