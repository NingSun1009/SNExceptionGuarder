//
//  NSMutableString+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSMutableString+SNExceptionGuarder.h"
#import "SNExceptionGuarder.h"

@implementation NSMutableString (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSCFString");
        
        // - replaceCharactersInRange:withString:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(replaceCharactersInRange:withString:)
                        withSwizzledSelector:@selector(eg_replaceCharactersInRange:withString:)];
        
        // - insertString:atIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(insertString:atIndex:)
                        withSwizzledSelector:@selector(eg_insertString:atIndex:)];
        
        // - deleteCharactersInRange:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(deleteCharactersInRange:)
                        withSwizzledSelector:@selector(eg_deleteCharactersInRange:)];
        
        // - characterAtIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(characterAtIndex:)
                        withSwizzledSelector:@selector(eg_characterAtIndex:)];
        
        // - substringFromIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(substringFromIndex:)
                        withSwizzledSelector:@selector(eg_substringFromIndex:)];
        
        // - substringToIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(substringToIndex:)
                        withSwizzledSelector:@selector(eg_substringToIndex:)];
        
        // - substringWithRange:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(substringWithRange:)
                        withSwizzledSelector:@selector(eg_substringWithRange:)];
        
        // - stringByReplacingOccurrencesOfString:withString:options:range:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                        withSwizzledSelector:@selector(eg_stringByReplacingOccurrencesOfString:withString:options:range:)];
        
        // - stringByReplacingCharactersInRange:withString:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(stringByReplacingCharactersInRange:withString:)
                        withSwizzledSelector:@selector(eg_stringByReplacingCharactersInRange:withString:)];
        
        // - rangeOfString:options:range:locale:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(rangeOfString:options:range:locale:)
                        withSwizzledSelector:@selector(eg_rangeOfString:options:range:locale:)];
        
        // - stringByAppendingString:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(stringByAppendingString:)
                        withSwizzledSelector:@selector(eg_stringByAppendingString:)];
        
        // - initWithUTF8String:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(initWithUTF8String:)
                        withSwizzledSelector:@selector(eg_initWithUTF8String:)];
        
        // - initWithFormat:locale:arguments:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(initWithFormat:locale:arguments:)
                        withSwizzledSelector:@selector(eg_initWithFormat:locale:arguments:)];
        
        // - initWithCharactersNoCopy:length:freeWhenDone:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(initWithCharactersNoCopy:length:freeWhenDone:)
                        withSwizzledSelector:@selector(eg_initWithCharactersNoCopy:length:freeWhenDone:)];
        
        // - appendString:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(appendString:)
                        withSwizzledSelector:@selector(eg_appendString:)];
    });
}

#pragma mark - swizzledMethods

// - replaceCharactersInRange:withString:
- (void)eg_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    @try {
        [self eg_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - insertString:atIndex:
- (void)eg_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    @try {
        [self eg_insertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - deleteCharactersInRange:
- (void)eg_deleteCharactersInRange:(NSRange)range {
    @try {
        [self eg_deleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - characterAtIndex:
- (unichar)eg_characterAtIndex:(NSUInteger)index {
    unichar characteristic;
    @try {
        characteristic = [self eg_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *msg = @"SNExceptionGuarder return a without assign unichar.";
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:msg];
    }
    @finally {
        return characteristic;
    }
}

// - substringFromIndex:
- (instancetype)eg_substringFromIndex:(NSUInteger)index {
    NSMutableString *subString = nil;
    @try {
        subString = [self eg_substringFromIndex:index];
    }
    @catch (NSException *exception) {
        subString = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - substringToIndex:
- (instancetype)eg_substringToIndex:(NSUInteger)index {
    NSMutableString *subString = nil;
    @try {
        subString = [self eg_substringToIndex:index];
    }
    @catch (NSException *exception) {
        subString = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - substringWithRange:
- (instancetype)eg_substringWithRange:(NSRange)range {
    NSMutableString *subString = nil;
    @try {
        subString = [self eg_substringWithRange:range];
    }
    @catch (NSException *exception) {
        subString = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return subString;
    }
}

// - stringByReplacingOccurrencesOfString:withString:options:range:
- (instancetype)eg_stringByReplacingOccurrencesOfString:(NSString *)targetStr
                                              withString:(NSString *)replaceStr
                                                 options:(NSStringCompareOptions)options
                                                   range:(NSRange)searchRange {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_stringByReplacingOccurrencesOfString:targetStr
                                                       withString:replaceStr
                                                          options:options
                                                            range:searchRange];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - stringByReplacingCharactersInRange:withString:
- (instancetype)eg_stringByReplacingCharactersInRange:(NSRange)range
                                            withString:(NSString *)replaceStr {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_stringByReplacingCharactersInRange:range
                                                     withString:replaceStr];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - rangeOfString:options:range:locale:
- (NSRange)eg_rangeOfString:(NSString *)searchString
                       options:(NSStringCompareOptions)mask
                         range:(NSRange)rangeOfReceiverToSearch
                        locale:(nullable NSLocale *)locale {
    NSRange range;
    @try {
        range = [self eg_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return range;
    }
}

// - stringByAppendingString:
- (instancetype)eg_stringByAppendingString:(NSString *)aString {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_stringByAppendingString:aString];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithUTF8String:
- (nullable instancetype)eg_initWithUTF8String:(const char *)nullTerminatedCString {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_initWithUTF8String:nullTerminatedCString];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithFormat:locale:arguments:
- (instancetype)eg_initWithFormat:(NSString *)format
                              locale:(nullable id)locale
                           arguments:(va_list)argList {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_initWithFormat:format locale:locale arguments:argList];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - initWithCharactersNoCopy:length:freeWhenDone:
- (instancetype)eg_initWithCharactersNoCopy:(unichar *)characters
                                        length:(NSUInteger)length
                                  freeWhenDone:(BOOL)freeBuffer {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_initWithCharactersNoCopy:characters
                                               length:length
                                         freeWhenDone:freeBuffer];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

// - appendString:
- (nullable instancetype)eg_appendString:(const char *)aString {
    NSMutableString *newStr = nil;
    @try {
        newStr = [self eg_appendString:aString];
    }
    @catch (NSException *exception) {
        newStr = nil;
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return newStr;
    }
}

@end
