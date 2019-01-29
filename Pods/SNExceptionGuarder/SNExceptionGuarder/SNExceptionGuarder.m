//
//  SNExceptionGuarder.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "SNExceptionGuarder.h"

const NSString *kErrorName = @"errorName";
const NSString *kErrorLocation = @"errorLocation";
const NSString *kErrorReason = @"errorReason";
const NSString *kDefaultOP = @"defaultOP";
const NSString *kCallStackSymbols = @"callStackSymbols";
const NSString *kException = @"exception";

@implementation SNExceptionGuarder

+ (instancetype)shareInstance {
    static SNExceptionGuarder *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SNExceptionGuarder alloc] init];
    });
    return shareInstance;
}

- (void)startWithBlock:(SNExceptionGuarderBlock)block {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject guardExceptionExchangeMethod];
        
        [NSArray guardExceptionExchangeMethod];
        [NSMutableArray guardExceptionExchangeMethod];
        
        [NSDictionary guardExceptionExchangeMethod];
        [NSMutableDictionary guardExceptionExchangeMethod];
        
        [NSString guardExceptionExchangeMethod];
        [NSMutableString guardExceptionExchangeMethod];
        
        self.block = [block copy];
    });
}

- (void)noteErrorWithException:(NSException *)exception defaultOP:(NSString *)defaultOP {
    //堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [self getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"崩溃方法定位失败,请您查看函数调用栈来排查错误原因";
    }
    NSString *errorName = exception.name;
    NSString *errorReason = exception.reason;
    //errorReason 可能为 -[__NSCFConstantString eg_CharacterAtIndex:]: Range or index out of bounds
    //将eg_去掉
    errorReason = [errorReason stringByReplacingOccurrencesOfString:@"eg_" withString:@""];
    NSString *errorLocation = [NSString stringWithFormat:@"Error Location:%@",mainCallStackSymbolMsg];
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@",SNExceptionGuarderSeparatorWithFlag, errorName, errorReason, errorLocation, defaultOP];
    logErrorMessage = [NSString stringWithFormat:@"%@\n\n%@\n\n",logErrorMessage,SNExceptionGuarderSeparator];
    NSLog(@"%@",logErrorMessage);
    NSDictionary *errorInfoDic = @{
                                   kErrorName        : errorName,
                                   kErrorReason      : errorReason,
                                   kErrorLocation    : errorLocation,
                                   kDefaultOP        : defaultOP,
                                   kException        : exception,
                                   kCallStackSymbols : callStackSymbolsArr
                                   };
    //将错误信息放在字典里，上报
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block(errorInfoDic);
        }
    });
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */
- (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                //filter category and system class
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

@end
