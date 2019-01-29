//
//  NSArray+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSArray+SNExceptionGuarder.h"
#import "SNExceptionGuarder.h"

@implementation NSArray (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        // - initWithObjects:count:
        [self exchangeInstanceMethodForClass:__NSPlaceholderArray
                            originalSelector:@selector(initWithObjects:count:)
                        withSwizzledSelector:@selector(eg_initWithObjects:count:)];
        
        // - objectAtIndex:
        [self exchangeInstanceMethodForClass:__NSArrayI
                            originalSelector:@selector(objectAtIndex:)
                        withSwizzledSelector:@selector(eg_arrayI_objectAtIndex:)];
        
        if (@available(iOS 10.0, *)) {
            [self exchangeInstanceMethodForClass:__NSSingleObjectArrayI
                        originalSelector:@selector(objectAtIndex:)
                    withSwizzledSelector:@selector(eg_singleObjectArrayI_objectAtIndex:)];
        }
        
        if (@available(iOS 9.0, *)) {
            [self exchangeInstanceMethodForClass:__NSArray0
                        originalSelector:@selector(objectAtIndex:)
                    withSwizzledSelector:@selector(eg_array0_objectAtIndex:)];
        }
        
        // - objectAtIndexedSubscript:
        if (@available(iOS 11.0, *)) {
            [self exchangeInstanceMethodForClass:__NSArrayI
                        originalSelector:@selector(objectAtIndexedSubscript:)
                    withSwizzledSelector:@selector(eg_arrayI_objectAtIndexedSubscript:)];
        }
        
        // - subarrayWithRange:
        [self exchangeInstanceMethodForClass:[self class]
                            originalSelector:@selector(subarrayWithRange:)
                        withSwizzledSelector:@selector(eg_subarrayWithRange:)];
        
        // - getObjects:range:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(getObjects:range:)
                withSwizzledSelector:@selector(eg_array_getObjects:range:)];
        
        if (@available(iOS 10.0, *)) {
            [self exchangeInstanceMethodForClass:__NSSingleObjectArrayI
                        originalSelector:@selector(getObjects:range:)
                    withSwizzledSelector:@selector(eg_singleObjectArrayI_getObjects:range:)];
        }

        [self exchangeInstanceMethodForClass:__NSArrayI
                            originalSelector:@selector(getObjects:range:)
                        withSwizzledSelector:@selector(eg_arrayI_getObjects:range:)];
        
    });
}

#pragma mark - swizzledMethods

// - initWithObjects:count:
- (instancetype)eg_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects
                             count:(NSUInteger)cnt {
    //去掉nil的数据
    if (objects != NULL) {
        id instance = nil;
        @try {
            instance = [self eg_initWithObjects:objects count:cnt];
        }
        @catch (NSException *exception) {
            NSString *defaultToDo = @"SNExceptionGuarder remove nil object and instance a array.";
            [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:defaultToDo];
            //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
            NSInteger newObjsIndex = 0;
            id  _Nonnull __unsafe_unretained newObjects[cnt];
            for (int i = 0; i < cnt; i++) {
                if (objects[i] != nil) {
                    newObjects[newObjsIndex] = objects[i];
                    newObjsIndex++;
                }
            }
            instance = [self eg_initWithObjects:newObjects count:newObjsIndex];
        }
        @finally {
            return instance;
        }
    } else { //兼容[NSArray arrayWithObjects:nil count:1]这种异常
        if (cnt > 0) {
            NSString *reason = [NSString stringWithFormat:@"-[__NSPlaceholderArray initWithObjects:count:]: \
                                pointer to objects array is NULL but length is %lu",(unsigned long)cnt];
            NSException *exception = [NSException exceptionWithName:@"NSInvalidArgumentException"
                                                             reason:reason
                                                           userInfo:nil];
            [[SNExceptionGuarder shareInstance] noteErrorWithException:exception
                                                           defaultOP:SNExceptionGuarderReturnNil];
            return nil;
        }
    }
    return [self eg_initWithObjects:objects count:cnt];
}

// - objectAtIndex:  (for __NSArrayI)
- (id)eg_arrayI_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self eg_arrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - objectAtIndex:  (for __NSSingleObjectArrayI)
- (id)eg_singleObjectArrayI_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self eg_singleObjectArrayI_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - objectAtIndex:  (for __NSArray0)
- (id)eg_array0_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self eg_array0_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - objectAtIndexedSubscript: (for __NSArrayI)
- (id)eg_arrayI_objectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    @try {
        object = [self eg_arrayI_objectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - subarrayWithRange:
- (id)eg_subarrayWithRange:(NSRange)range {
    id object = nil;
    @try {
        object = [self eg_subarrayWithRange:range];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - getObjects:range: (for __NSArray)
- (void)eg_array_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self eg_array_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - getObjects:range: (for __NSSingleObjectArrayI)
- (void)eg_singleObjectArrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self eg_singleObjectArrayI_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - getObjects:range: (for __NSArrayI)
- (void)eg_arrayI_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self eg_arrayI_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

@end
