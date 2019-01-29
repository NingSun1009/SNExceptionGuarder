//
//  SNExceptionGuarderProtocol.h
//  SNExceptionGuarder
//
//  Created by Ning Sun on 2019/1/25.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SNExceptionGuarderProtocol <NSObject>

@required
+ (void)guardExceptionExchangeMethod;

@end

NS_ASSUME_NONNULL_END
