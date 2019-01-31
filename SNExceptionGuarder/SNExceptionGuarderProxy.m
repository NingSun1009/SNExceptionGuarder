//
//  SNExceptionGuarderProxy.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

const NSString *kErrorName = @"errorName";
const NSString *kErrorLocation = @"errorLocation";
const NSString *kErrorReason = @"errorReason";
const NSString *kDefaultOP = @"defaultOP";
const NSString *kCallStackSymbols = @"callStackSymbols";
const NSString *kException = @"exception";

#import "SNExceptionGuarderProxy.h"
#import <objc/runtime.h>

#import "NSObject+SNExceptionGuarder.h"

#import "NSArray+SNExceptionGuarder.h"
#import "NSMutableArray+SNExceptionGuarder.h"

#import "NSDictionary+SNExceptionGuarder.h"
#import "NSMutableArray+SNExceptionGuarder.h"

#import "NSString+SNExceptionGuarder.h"
#import "NSMutableString+SNExceptionGuarder.h"

#import "NSAttributedString+SNExceptionGuarder.h"
#import "NSMutableAttributedString+SNExceptionGuarder.h"

#import "NSSet+SNExceptionGuarder.h"
#import "NSMutableSet+SNExceptionGuarder.h"

#import "NSTimer+SNExceptionGuarder.h"
#import "NSObject+SNZombie.h"

@interface SNExceptionGuarderProxy() {
    NSMutableSet *_currentClassesSet;
    NSMutableSet *_blackClassesSet;
    NSInteger _currentClassSize;
    // Protect _blackClassesSet and _currentClassesSet atomic.
    dispatch_semaphore_t _classArrayLock;
    // Protect swizzle atomic.
    dispatch_semaphore_t _swizzleLock;
}

@end

@implementation SNExceptionGuarderProxy

#pragma mark - InitMethods

+ (instancetype)shareInstance {
    static SNExceptionGuarderProxy *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SNExceptionGuarderProxy alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _blackClassesSet = [NSMutableSet new];
        _currentClassesSet = [NSMutableSet new];
        _currentClassSize = 0;
        _classArrayLock = dispatch_semaphore_create(1);
        _swizzleLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)setEnableGuardException:(BOOL)enableGuardException {
    dispatch_semaphore_wait(_swizzleLock, DISPATCH_TIME_FOREVER);
    if (_enableGuardException != enableGuardException) {
        _enableGuardException = enableGuardException;
        if ((_exceptionGuarderType & SNExceptionGuarderTypeUnrecognizedSelector)
            == SNExceptionGuarderTypeUnrecognizedSelector) {
            [NSObject exceptionGuarderExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeDictionaryContainer)
            == SNExceptionGuarderTypeDictionaryContainer) {
            [NSDictionary guardExceptionExchangeMethod];
            [NSMutableDictionary guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeArrayContainer)
            == SNExceptionGuarderTypeArrayContainer) {
            [NSArray guardExceptionExchangeMethod];
            [NSMutableArray guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeSetContainer)
            == SNExceptionGuarderTypeSetContainer) {
            [NSSet guardExceptionExchangeMethod];
            [NSMutableSet guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeNSStringContainer)
            == SNExceptionGuarderTypeNSStringContainer) {
            [NSString guardExceptionExchangeMethod];
            [NSMutableString guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeNSAttributedStringContainer)
            == SNExceptionGuarderTypeNSAttributedStringContainer) {
            [NSAttributedString guardExceptionExchangeMethod];
            [NSMutableAttributedString guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeNSTimer)
            == SNExceptionGuarderTypeNSTimer) {
            [NSTimer guardExceptionExchangeMethod];
        }
        if ((_exceptionGuarderType & SNExceptionGuarderTypeZombie)
            == SNExceptionGuarderTypeZombie) {
            [NSObject zombieExchangeMethod];
        }
    }
    dispatch_semaphore_signal(_swizzleLock);
}

- (void)setExceptionGuarderType:(SNExceptionGuarderType)exceptionGuarderType {
    if (_exceptionGuarderType != exceptionGuarderType) {
        _exceptionGuarderType = exceptionGuarderType;
    }
}

#pragma mark - Static Methods

+ (void)noteErrorWithException:(NSException *)exception
                     defaultOP:(NSString *)defaultOP {
    // Stack data.
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    // Gets the array string format instantiated in which method of
    // which class -[className methodName] or +[className methodName].
    NSString *mainCallStackSymbolMsg = [self getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
    }
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    // ErrorReason may be -[__NSCFConstantString eg_CharacterAtIndex:]:
    // Range or index out of bounds remove eg_.
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"eg_" withString:@""];
    NSString *errorLocation = [NSString stringWithFormat:@"Error Location:%@",mainCallStackSymbolMsg];
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@",
                                 SNExceptionGuarderSeparatorWithFlag,
                                 errorName,
                                 errorReason,
                                 errorLocation,
                                 defaultOP];
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n",
                       logErrorMessage,
                       SNExceptionGuarderSeparator];
    NSLog(@"%@",logErrorMessage);
    NSDictionary *errorInfoDic = @{
                                   kErrorName        : errorName,
                                   kErrorReason      : errorReason,
                                   kErrorLocation    : errorLocation,
                                   kDefaultOP        : defaultOP,
                                   kException        : exception,
                                   kCallStackSymbols : callStackSymbolsArr
                                   };
    // Put the error information in the dictionary and report it.
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([SNExceptionGuarderProxy shareInstance].block) {
            [SNExceptionGuarderProxy shareInstance].block(errorInfoDic);
        }
    });
}

// Gets information about the main stack crash minification
// < matched according to the regular expression >.
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    // MainCallStackSymbolMsg is formatted as +[className methodName] or -[className methodName].
    __block NSString *mainCallStackSymbolMsg = nil;
    // The matching format is +[className methodName] or -[className methodName].
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        [regularExp enumerateMatchesInString:callStackSymbol
                                     options:NSMatchingReportProgress
                                       range:NSMakeRange(0, callStackSymbol.length)
                                  usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                // get className.
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                // filter category and system class.
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                }
                *stop = YES;
            }
        }];
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    return mainCallStackSymbolMsg;
}

#pragma mark - Zombie collection

- (void)addZombieObjectArray:(NSArray*)objects {
    if (!objects) {
        return;
    }
    dispatch_semaphore_wait(_classArrayLock, DISPATCH_TIME_FOREVER);
    [_blackClassesSet addObjectsFromArray:objects];
    dispatch_semaphore_signal(_classArrayLock);
}

- (NSSet *)blackClassesSet {
    return _blackClassesSet;
}

- (void)addCurrentZombieClass:(Class)object {
    if (object) {
        dispatch_semaphore_wait(_classArrayLock, DISPATCH_TIME_FOREVER);
        _currentClassSize = _currentClassSize + class_getInstanceSize(object);
        [_currentClassesSet addObject:object];
        dispatch_semaphore_signal(_classArrayLock);
    }
}

- (void)removeCurrentZombieClass:(Class)object {
    if (object) {
        dispatch_semaphore_wait(_classArrayLock, DISPATCH_TIME_FOREVER);
        _currentClassSize = _currentClassSize - class_getInstanceSize(object);
        [_currentClassesSet removeObject:object];
        dispatch_semaphore_signal(_classArrayLock);
    }
}

- (NSSet *)currentClassesSet {
    return _currentClassesSet;
}

- (NSInteger)currentClassSize {
    return _currentClassSize;
}

- (nullable id)objectFromCurrentClassesSet {
    NSEnumerator *objectEnum = [_currentClassesSet objectEnumerator];
    for (id object in objectEnum) {
        return object;
    }
    return nil;
}

@end
