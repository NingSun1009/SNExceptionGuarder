//
//  SNExceptionGuarderProxy.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SNExceptionGuarderReturnNil  @"SNExceptionGuarder return nil to guard crash."
#define SNExceptionGuarderIgnore     @"SNExceptionGuarder ignore this operation to guard crash."

#define SNExceptionGuarderSeparator         @"================================================================"
#define SNExceptionGuarderSeparatorWithFlag @"====================SNExceptionGuarder Log======================"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, SNExceptionGuarderType) {
    SNExceptionGuarderTypeNone                           = 0,
    SNExceptionGuarderTypeUnrecognizedSelector           = 1 << 0,
    SNExceptionGuarderTypeDictionaryContainer            = 1 << 1,
    SNExceptionGuarderTypeArrayContainer                 = 1 << 2,
    SNExceptionGuarderTypeSetContainer                   = 1 << 3,
    SNExceptionGuarderTypeNSStringContainer              = 1 << 4,
    SNExceptionGuarderTypeNSAttributedStringContainer    = 1 << 5,
    SNExceptionGuarderTypeNSTimer                        = 1 << 6,
    SNExceptionGuarderTypeZombie                         = 1 << 7,
    SNExceptionGuarderTypeAll                            = (SNExceptionGuarderTypeUnrecognizedSelector |
                                                             SNExceptionGuarderTypeDictionaryContainer |
                                                                  SNExceptionGuarderTypeArrayContainer |
                                                                    SNExceptionGuarderTypeSetContainer |
                                                               SNExceptionGuarderTypeNSStringContainer |
                                                     SNExceptionGuarderTypeNSAttributedStringContainer |
                                                                         SNExceptionGuarderTypeNSTimer |
                                                                           SNExceptionGuarderTypeZombie),
};

typedef void(^SNExceptionGuarderBlock)(NSDictionary *params);

@interface SNExceptionGuarderProxy : NSObject

@property (nonatomic, copy) SNExceptionGuarderBlock block;

/**
 Setting hook excpetion status,default value is NO.
 */
@property (nonatomic, assign) BOOL enableGuardException;

/**
 Set exceptionGuarderType.
 */
@property (nonatomic, assign) SNExceptionGuarderType exceptionGuarderType;

+ (instancetype)shareInstance;

/**
 *  Messages that prompt for a crash (console output, notifications).
 *
 *  @param exception Caught exception.
 *  @param defaultOP The default operation.
 */
+ (void)noteErrorWithException:(NSException *)exception
                     defaultOP:(NSString *)defaultOP;

#pragma mark - Zombie collection

/**
 Real addZombieObjectArray invoke
 
 @param objects class array
 */
- (void)addZombieObjectArray:(NSArray *)objects;

/**
 Zombie only process the Set class
 */
@property (nonatomic, readonly, strong) NSSet *blackClassesSet;

/**
 Record the all Set class size
 */
@property (nonatomic, readonly, assign) NSInteger currentClassSize;

/**
 Add object to the currentClassesSet
 
 @param object NSObject
 */
- (void)addCurrentZombieClass:(Class)object;

/**
 Remove object from the currentClassesSet
 
 @param object NSObject
 */
- (void)removeCurrentZombieClass:(Class)object;

/**
 Record the objc_destructInstance instance object
 */
@property (nonatomic, readonly, strong) NSSet *currentClassesSet;

/**
 Random get the object from blackClassesSet
 
 @return NSObject
 */
- (nullable id)objectFromCurrentClassesSet;

@end

NS_ASSUME_NONNULL_END
