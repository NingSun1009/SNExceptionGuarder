//
//  NSObject+SNZombie.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/30.
//

#import "NSObject+SNZombie.h"
#import "NSObject+SNSwizzle.h"
#import "SNExceptionGuarderProxy.h"
#import <objc/runtime.h>

// MAX Memeory Size 5M.
const NSInteger MAX_ARRAY_SIZE = 1024 * 1024 * 5;

@interface SNZombieSelectorHandle : NSObject

@property (nonatomic, assign) id fromObject;

@end

@implementation SNZombieSelectorHandle

void unrecognizedSelectorZombie(SNZombieSelectorHandle *self, SEL _cmd) {
    
}

@end

@interface SNZombieSub : NSObject

@end

@implementation SNZombieSub

- (id)forwardingTargetForSelector:(SEL)selector{
    NSMethodSignature* sign = [self methodSignatureForSelector:selector];
    if (!sign) {
        id stub = [[SNZombieSelectorHandle new] autorelease];
        [stub setFromObject:self];
        class_addMethod([stub class], selector, (IMP)unrecognizedSelectorZombie, "v@:");
        return stub;
    }
    return [super forwardingTargetForSelector:selector];
}

@end

@implementation NSObject (SNZombie)

+ (void)zombieExchangeMethod {
    [self exchangeInstanceMethodForClass:[self class]
                        originalSelector:@selector(dealloc)
                    withSwizzledSelector:@selector(eg_dealloc)];
}

- (void)eg_dealloc{
    Class currentClass = self.class;
    
    // Check black list.
    if (![[[SNExceptionGuarderProxy shareInstance] blackClassesSet] containsObject:currentClass]) {
        [self eg_dealloc];
        return;
    }
    NSException *exception = [NSException exceptionWithName:@"Memory Bad Access"
                                                     reason:@""
                                                   userInfo:nil];
    [SNExceptionGuarderProxy noteErrorWithException:exception
                                          defaultOP:SNExceptionGuarderIgnore];
    // Check the array max size
    // Real remove less than MAX_ARRAY_SIZE.
    if ([SNExceptionGuarderProxy shareInstance].currentClassSize > MAX_ARRAY_SIZE) {
        id object = [[SNExceptionGuarderProxy shareInstance] objectFromCurrentClassesSet];
        [[SNExceptionGuarderProxy shareInstance] removeCurrentZombieClass:object_getClass(object)];
        object?free((__bridge void *)(object)):nil;
    }
    objc_destructInstance(self);
    object_setClass(self, [SNZombieSub class]);
    [[SNExceptionGuarderProxy shareInstance] addCurrentZombieClass:currentClass];
}

@end
