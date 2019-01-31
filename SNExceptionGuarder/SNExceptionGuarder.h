//
//  SNExceptionGuarder.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNExceptionGuarderProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface SNExceptionGuarder : NSObject

/**
 *  Config exception guard operation block.
 *
 *  @param block Exception reporting logic.
 */
+ (void)configWithBlock:(SNExceptionGuarderBlock)block;

/**
 Config the exception guard type, default:SNExceptionGuarderTypeNone.
 
 @param exceptionGuarderType SNExceptionGuarderType.
 */
+ (void)configExceptionGuarderType:(SNExceptionGuarderType)exceptionGuarderType;

/**
 Only handle the black list zombie object.
 
 @param objects Class Array.
 */
+ (void)addZombieObjectArray:(NSArray *)objects;

/**
 Start the exception protect.
 */
+ (void)startGuardException;

/**
 Stop the exception protect.
 */
+ (void)stopGuardException;

@end

NS_ASSUME_NONNULL_END
