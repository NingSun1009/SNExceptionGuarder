//
//  SNExceptionGuarder.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "SNExceptionGuarder.h"

@implementation SNExceptionGuarder

+ (void)configWithBlock:(SNExceptionGuarderBlock)block {
    [SNExceptionGuarderProxy shareInstance].block = [block copy];
}

+ (void)configExceptionGuarderType:(SNExceptionGuarderType)exceptionGuarderType {
    [SNExceptionGuarderProxy shareInstance].exceptionGuarderType = exceptionGuarderType;
}

+ (void)addZombieObjectArray:(NSArray *)objects {
    [[SNExceptionGuarderProxy shareInstance] addZombieObjectArray:objects];
}

+ (void)startGuardException {
    [SNExceptionGuarderProxy shareInstance].enableGuardException = YES;
}

+ (void)stopGuardException {
    [SNExceptionGuarderProxy shareInstance].enableGuardException = NO;
}

@end
