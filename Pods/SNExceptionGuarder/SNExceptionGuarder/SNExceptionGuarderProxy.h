//
//  SNExceptionGuarderProxy.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNExceptionGuarder.h"

#define SNExceptionGuarderReturnNil  @"SNExceptionGuarder return nil to guard crash."
#define SNExceptionGuarderIgnore     @"SNExceptionGuarder ignore this operation to guard crash."

#define SNExceptionGuarderSeparator         @"================================================================"
#define SNExceptionGuarderSeparatorWithFlag @"========================SNExceptionGuarder Log===================="

NS_ASSUME_NONNULL_BEGIN

@interface SNExceptionGuarderProxy : NSObject

- (void)proxyMethod;

@end

NS_ASSUME_NONNULL_END
