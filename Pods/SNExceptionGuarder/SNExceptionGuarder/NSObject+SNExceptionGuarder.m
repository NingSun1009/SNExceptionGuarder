//
//  NSObject+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSObject+SNExceptionGuarder.h"
#import "SNExceptionGuarder.h"

@implementation NSObject (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // for Instance
        // - setValue:forKey:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(setValue:forKey:)
                        withSwizzledSelector:@selector(eg_setValue:forKey:)];
        
        // - setValue:forKeyPath:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(setValue:forKeyPath:)
                        withSwizzledSelector:@selector(eg_setValue:forKeyPath:)];
        
        // - setValue:forUndefinedKey:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(setValue:forUndefinedKey:)
                        withSwizzledSelector:@selector(eg_setValue:forUndefinedKey:)];
        
        // - setValuesForKeysWithDictionary:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(setValuesForKeysWithDictionary:)
                        withSwizzledSelector:@selector(eg_setValuesForKeysWithDictionary:)];
        
        // - methodSignatureForSelector:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(methodSignatureForSelector:)
                        withSwizzledSelector:@selector(eg_methodSignatureForSelector:)];
        
        // - forwardInvocation:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(forwardInvocation:)
                        withSwizzledSelector:@selector(eg_forwardInvocation:)];
        
        //for Class
        // - methodSignatureForSelector:
        [self exchangeClassMethodForClass:[self class] originalSelector:@selector(methodSignatureForSelector:) withSwizzledSelector:@selector(eg_classMethodSignatureForSelector:)];
        
        // - forwardInvocation:
        [self exchangeClassMethodForClass:[self class] originalSelector:@selector(forwardInvocation:) withSwizzledSelector:@selector(eg_classForwardInvocation:)];
    });
}

#pragma mark - swizzledMethods

// - setValue:forKey:
- (void)eg_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self eg_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - setValue:forKeyPath:
- (void)eg_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self eg_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - setValue:forUndefinedKey:
- (void)eg_setValue:(id)value forUndefinedKey:(NSString *)key {
    @try {
        [self eg_setValue:value forUndefinedKey:key];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - setValuesForKeysWithDictionary:
- (void)eg_setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    @try {
        [self eg_setValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - methodSignatureForSelector:
- (NSMethodSignature *)eg_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self eg_methodSignatureForSelector:aSelector];
    if (ms) {
        return ms;
    }
    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

- (NSMethodSignature *)eg_classMethodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *ms = [self eg_classMethodSignatureForSelector:aSelector];
    if (ms) {
        return ms;
    }
    return [self.class checkObjectSignatureAndCurrentClass:self.class];
}

// - forwardInvocation:
- (void)eg_forwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(anInvocation.selector)];
    NSException *exception = [NSException exceptionWithName:@"NSInvalidArgumentException" reason:message userInfo:nil];
    [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
}

- (void)eg_classForwardInvocation:(NSInvocation *)anInvocation {
    NSString *message = [NSString stringWithFormat:@"Unrecognized instance class:%@ and selector:%@",NSStringFromClass(self.class),NSStringFromSelector(anInvocation.selector)];
    NSException *exception = [NSException exceptionWithName:@"NSInvalidArgumentException" reason:message userInfo:nil];
    [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
}

/**
 * Check the class method signature to the [NSObject class]
 * If not equals,return nil
 * If equals,return the v@:@ method
 
 @param currentClass Class
 @return NSMethodSignature
 */
+ (NSMethodSignature *)checkObjectSignatureAndCurrentClass:(Class)currentClass{
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation(currentClass, @selector(methodSignatureForSelector:));
    // If current class override methodSignatureForSelector return nil
    if (originIMP != currentClassIMP){
        return nil;
    }
    // Customer method signature
    // void xxx(id,sel,id)
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

@end
