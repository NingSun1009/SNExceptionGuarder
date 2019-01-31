//
//  AViewController.m
//  SNExceptionGuarderDemo
//
//  Created by Ning Sun on 2019/1/30.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Timer";
    [self testTimer];
}

#pragma mark - Test Timer

- (void)testTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scheduledMethod) userInfo:nil repeats:YES];
}

- (void)scheduledMethod{
    NSLog(@"timers");
}

- (void)dealloc {
    NSLog(@"__dealloc__");
}

@end
