//
//  BViewController.m
//  SNExceptionGuarderDemo
//
//  Created by Ning Sun on 2019/1/31.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@property (nonatomic, strong) NSArray *array;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Zombie";
    [self testZombie];
}

#pragma mark - test Zombie

- (void)testZombie {
    for (int i = 0 ; i < 20; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.array = @[@"test"];
        });
    }
    self.array = @[@"test"];
}

@end
