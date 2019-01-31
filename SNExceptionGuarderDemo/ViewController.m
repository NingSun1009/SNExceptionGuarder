//
//  ViewController.m
//  SNExceptionGuarderDemo
//
//  Created by Ning Sun on 2019/1/29.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "ViewController.h"
#import <SNExceptionGuarder.h>
#import "AViewController.h"
#import "BViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSArray *arr;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, copy) NSDictionary *dict;
@property (nonatomic, strong) NSMutableDictionary *dictM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startGuard:(id)sender {
    // Enable exception catching.
    [SNExceptionGuarder startGuardException];
}

- (IBAction)stopGuard:(id)sender {
    // Turn off exception catching.
    [SNExceptionGuarder stopGuardException];
}

#pragma mark - test Methods

- (IBAction)testUnRecognized:(id)sender {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [NSObject performSelector:@selector(test)];
    NSObject *obj = [[NSObject alloc] init];
    [obj performSelector:@selector(test)];
#pragma clang diagnostic pop
}

- (IBAction)testDict:(id)sender {
    id value = nil;
    NSDictionary *dic = @{@"key":value};
    NSLog(@"dic:%@",dic);
}

- (IBAction)testArr:(id)sender {
    NSArray *arr = @[];
    NSLog(@"object:%@",[arr objectAtIndex:1]);
}

- (IBAction)testSet:(id)sender {
    id value = nil;
    NSSet *set = [NSSet setWithObject:value];
    NSLog(@"set:%@",set);
}

- (IBAction)testMutStr:(id)sender {
    id value = nil;
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"123"];
    [str appendString:value];
}

- (IBAction)testAtrStr:(id)sender {
    id value = nil;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:value];
    NSLog(@"str:%@",str);
}

- (IBAction)testTimer:(id)sender {
    AViewController *vc = [[AViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)testZombie:(id)sender {
    BViewController *vc = [[BViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
