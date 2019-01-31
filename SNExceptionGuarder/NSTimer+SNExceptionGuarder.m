//
//  NSTimer+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSTimer+SNExceptionGuarder.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"

@interface SNTimerProxy : NSObject

@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 weak reference target.
 */
@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL selector;

@property (nonatomic, assign) id userInfo;

/**
 TimerObject Associated NSTimer.
 */
@property (nonatomic, weak) NSTimer *timer;

/**
 Record the target class name.
 */
@property (nonatomic, copy) NSString *targetClassName;

/**
 Record the target method name.
 */
@property (nonatomic, copy) NSString *targetMethodName;

@end

@implementation SNTimerProxy

- (void)fireTimer{
    if (!self.target) {
        [self.timer invalidate];
        self.timer = nil;
        NSString *reason = [NSString stringWithFormat:@"Need invalidate timer from target:%@ method:%@",self.targetClassName,self.targetMethodName];
        NSException *exception = [NSException exceptionWithName:@"NSTimer Issue"
                                                         reason:reason
                                                       userInfo:nil];
        [SNExceptionGuarderProxy noteErrorWithException:exception
                                              defaultOP:SNExceptionGuarderIgnore];
        return;
    }
    if ([self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:self.timer];
#pragma clang diagnostic pop
    }
}

@end

@implementation NSTimer (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    [self exchangeClassMethodForClass:[NSTimer class]
                     originalSelector:@selector(scheduledTimerWithTimeInterval:
                                                target:
                                                selector:
                                                userInfo:
                                                repeats:)
                 withSwizzledSelector:@selector(eg_scheduledTimerWithTimeInterval:
                                                target:
                                                selector:
                                                userInfo:
                                                repeats:)];
}

+ (NSTimer*)eg_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                       target:(id)aTarget
                                     selector:(SEL)aSelector
                                     userInfo:(nullable id)userInfo
                                      repeats:(BOOL)yesOrNo{
    if (!yesOrNo) {
        return [self eg_scheduledTimerWithTimeInterval:timeInterval
                                                target:aTarget
                                              selector:aSelector
                                              userInfo:userInfo
                                               repeats:yesOrNo];
    }
    SNTimerProxy *timerProxy = [SNTimerProxy new];
    timerProxy.timeInterval = timeInterval;
    timerProxy.target = aTarget;
    timerProxy.selector = aSelector;
    timerProxy.userInfo = userInfo;
    if (aTarget) {
        timerProxy.targetClassName = [NSString stringWithCString:object_getClassName(aTarget) encoding:NSASCIIStringEncoding];
    }
    timerProxy.targetMethodName = NSStringFromSelector(aSelector);
    NSTimer *timer = [NSTimer eg_scheduledTimerWithTimeInterval:timeInterval
                                                         target:timerProxy
                                                       selector:@selector(fireTimer)
                                                       userInfo:userInfo
                                                        repeats:yesOrNo];
    timerProxy.timer = timer;
    return timer;
}

@end
