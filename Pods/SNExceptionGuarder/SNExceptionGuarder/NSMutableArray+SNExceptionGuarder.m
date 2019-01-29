//
//  NSMutableArray+SNExceptionGuarder.m
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "NSMutableArray+SNExceptionGuarder.h"
#import "SNExceptionGuarder.h"

@implementation NSMutableArray (SNExceptionGuarder)

+ (void)guardExceptionExchangeMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSArrayM");
        
        // - objectAtIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(objectAtIndex:)
                        withSwizzledSelector:@selector(eg_objectAtIndex:)];
        
        // - objectAtIndexedSubscript:
        if (@available(iOS 11.0, *)) {
            [self exchangeInstanceMethodForClass:class
                                originalSelector:@selector(objectAtIndexedSubscript:)
                            withSwizzledSelector:@selector(eg_objectAtIndexedSubscript:)];
        }
        
        // - setObject:atIndexedSubscript:
        if (@available(iOS 10.0, *)) {
            [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(setObject:atIndexedSubscript:)
                    withSwizzledSelector:@selector(eg_setObject:atIndexedSubscript:)];
        } else {
            // - setObject:atIndex:
            [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(setObject:atIndex:)
                    withSwizzledSelector:@selector(eg_setObject:atIndex:)];
        }
        
        // - removeObjectAtIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(removeObjectAtIndex:)
                        withSwizzledSelector:@selector(eg_removeObjectAtIndex:)];
        
        // - insertObject:atIndex:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(insertObject:atIndex:)
                        withSwizzledSelector:@selector(eg_insertObject:atIndex:)];
        
        // - getObjects:range:
        [self exchangeInstanceMethodForClass:class
                            originalSelector:@selector(getObjects:range:)
                        withSwizzledSelector:@selector(eg_getObjects:range:)];
        
        // - replaceObjectAtIndex:withObject:
        [self exchangeInstanceMethodForClass:class
                    originalSelector:@selector(replaceObjectAtIndex:withObject:)
                withSwizzledSelector:@selector(eg_replaceObjectAtIndex:withObject:)];
        
        // - removeObjectsInRange:
        if (@available(iOS 10.0, *)) {
            [self exchangeInstanceMethodForClass:class
                        originalSelector:@selector(removeObjectsInRange:)
                    withSwizzledSelector:@selector(eg_removeObjectsInRange:)];
        } else {
            [self exchangeInstanceMethodForClass:[self class]
                        originalSelector:@selector(removeObjectsInRange:)
                    withSwizzledSelector:@selector(eg_removeObjectsInRange:)];
        }
        
        // - removeObjectsAtIndexes:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(removeObjectsAtIndexes:)
                withSwizzledSelector:@selector(eg_removeObjectsAtIndexes:)];
        
        // - insertObjects:atIndexes:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(insertObjects:atIndexes:)
                withSwizzledSelector:@selector(eg_insertObjects:atIndexes:)];
        
        // - removeObjectIdenticalTo:inRange:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(removeObjectIdenticalTo:inRange:)
                withSwizzledSelector:@selector(eg_removeObjectIdenticalTo:inRange:)];
        
        // - replaceObjectsAtIndexes:withObjects:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(replaceObjectsAtIndexes:withObjects:)
                withSwizzledSelector:@selector(eg_replaceObjectsAtIndexes:withObjects:)];
        
        // - replaceObjectsInRange:withObjectsFromArray:range:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(replaceObjectsInRange:withObjectsFromArray:range:)
                withSwizzledSelector:@selector(eg_replaceObjectsInRange:withObjectsFromArray:range:)];
        
        // - replaceObjectsInRange:withObjectsFromArray:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(replaceObjectsInRange:withObjectsFromArray:)
                withSwizzledSelector:@selector(eg_replaceObjectsInRange:withObjectsFromArray:)];
        
        // - removeObject:inRange:
        [self exchangeInstanceMethodForClass:[self class]
                    originalSelector:@selector(removeObject:inRange:)
                withSwizzledSelector:@selector(eg_removeObject:inRange:)];
    });
}

#pragma mark - swizzledMethods

// - objectAtIndex:
- (id)eg_objectAtIndex:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self eg_objectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - objectAtIndexedSubscript:
- (id)eg_objectAtIndexedSubscript:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self eg_objectAtIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderReturnNil];
    }
    @finally {
        return object;
    }
}

// - setObject:atIndex:
- (void)eg_setObject:(id)obj atIndex:(NSUInteger)index {
    @try {
        [self eg_setObject:obj atIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - setObject:atIndexedSubscript:
- (void)eg_setObject:(id)obj atIndexedSubscript:(NSUInteger)index {
    @try {
        [self eg_setObject:obj atIndexedSubscript:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - removeObjectAtIndex:
- (void)eg_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self eg_removeObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - insertObject:atIndex:
- (void)eg_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self eg_insertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    }
    @finally {
        
    }
}

// - getObjects:range:
- (void)eg_getObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    @try {
        [self eg_getObjects:objects range:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceObjectAtIndex:withObject:
- (void)eg_replaceObjectAtIndex:(NSUInteger)index
                     withObject:(__unsafe_unretained id  _Nonnull *)objects {
    @try {
        [self eg_replaceObjectAtIndex:index withObject:objects];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeObjectsInRange:
- (void)eg_removeObjectsInRange:(NSRange)range {
    @try {
        [self eg_removeObjectsInRange:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeObjectsAtIndexes:
- (void)eg_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    @try {
        [self eg_removeObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - insertObjects:atIndexes:
- (void)eg_insertObjects:(NSArray<id> *)objects
               atIndexes:(NSIndexSet *)indexes {
    @try {
        [self eg_insertObjects:objects atIndexes:indexes];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeObjectIdenticalTo:inRange:
- (void)eg_removeObjectIdenticalTo:(id)anObject
                           inRange:(NSRange)range {
    @try {
        [self eg_removeObjectIdenticalTo:anObject inRange:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceObjectsAtIndexes:withObjects:
- (void)eg_replaceObjectsAtIndexes:(NSIndexSet *)indexes
                       withObjects:(NSArray<id> *)objects {
    @try {
        [self eg_replaceObjectsAtIndexes:indexes withObjects:objects];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceObjectsInRange:withObjectsFromArray:range:
- (void)eg_replaceObjectsInRange:(NSRange)range
         withObjectsFromArray:(NSArray<id> *)otherArray
                        range:(NSRange)otherRange {
    @try {
        [self eg_replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - replaceObjectsInRange:withObjectsFromArray:
- (void)eg_replaceObjectsInRange:(NSRange)range
         withObjectsFromArray:(NSArray<id> *)otherArray {
    @try {
        [self eg_replaceObjectsInRange:range withObjectsFromArray:otherArray];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

// - removeObject:inRange:
- (void)eg_removeObject:(id)anObject inRange:(NSRange)range {
    @try {
        [self eg_removeObject:anObject inRange:range];
    } @catch (NSException *exception) {
        [[SNExceptionGuarder shareInstance] noteErrorWithException:exception defaultOP:SNExceptionGuarderIgnore];
    } @finally {
        
    }
}

@end
