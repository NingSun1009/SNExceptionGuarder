//
//  NSMutableAttributedString+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSMutableAttributedString+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@implementation NSMutableAttributedString (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    Class class = NSClassFromString(@"NSConcreteMutableAttributedString");
    
    // - initWithString:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(initWithString:)
                    withSwizzledSelector:@selector(eg_initWithString:)];
    
    // - initWithString:attributes:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(initWithString:attributes:)
                    withSwizzledSelector:@selector(eg_initWithString:attributes:)];
    
    // - addAttribute:value:range:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(addAttribute:value:range:)
                    withSwizzledSelector:@selector(eg_addAttribute:value:range:)];
    
    // - addAttributes:range:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(addAttributes:range:)
                    withSwizzledSelector:@selector(eg_addAttributes:range:)];
    
    // - setAttributes:range:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(setAttributes:range:)
                    withSwizzledSelector:@selector(eg_setAttributes:range:)];
    
    // - removeAttribute:range:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(removeAttribute:range:)
                    withSwizzledSelector:@selector(eg_removeAttribute:range:)];
    
    // - deleteCharactersInRange:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(deleteCharactersInRange:)
                    withSwizzledSelector:@selector(eg_deleteCharactersInRange:)];
    
    // - replaceCharactersInRange:withString:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(replaceCharactersInRange:withString:)
                    withSwizzledSelector:@selector(eg_replaceCharactersInRange:withString:)];
    
    // - replaceCharactersInRange:withAttributedString:
    [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(replaceCharactersInRange:withAttributedString:)
                    withSwizzledSelector:@selector(eg_replaceCharactersInRange:withAttributedString:)];
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

// - initWithString:attributes:
- (instancetype)eg_initWithString:(NSString *)str
                    attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs {
    id object = nil;
    @try {
        object = [self eg_initWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - addAttribute:value:range:
- (void)eg_addAttribute:(NSAttributedStringKey)name
               value:(id)value
               range:(NSRange)range {
    @try {
        [self eg_addAttribute:name value:value range:range];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - addAttributes:range:
- (void)eg_addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
                range:(NSRange)range {
    @try {
        [self eg_addAttributes:attrs range:range];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - setAttributes:range:
- (void)eg_setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs
                   range:(NSRange)range {
    @try {
        [self eg_setAttributes:attrs range:range];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeAttribute:range:
- (void)eg_removeAttribute:(NSAttributedStringKey)name
                  range:(NSRange)range {
    @try {
        [self eg_removeAttribute:name range:range];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - deleteCharactersInRange:
- (void)eg_deleteCharactersInRange:(NSRange)range {
    @try {
        [self eg_deleteCharactersInRange:range];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceCharactersInRange:withString:
- (void)eg_replaceCharactersInRange:(NSRange)range
                      withString:(NSString *)str {
    @try {
        [self eg_replaceCharactersInRange:range withString:str];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceCharactersInRange:withAttributedString:
- (void)eg_replaceCharactersInRange:(NSRange)range
            withAttributedString:(NSAttributedString *)attrString {
    @try {
        [self eg_replaceCharactersInRange:range withAttributedString:attrString];
    } @catch (NSException *exception) {
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

@end
