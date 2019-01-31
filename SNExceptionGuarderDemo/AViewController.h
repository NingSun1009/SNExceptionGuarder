//
//  AViewController.h
//  SNExceptionGuarderDemo
//
//  Created by Ning Sun on 2019/1/30.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ABlock)();

@interface AViewController : UIViewController

@property (nonatomic, copy) ABlock block;

@end

NS_ASSUME_NONNULL_END
