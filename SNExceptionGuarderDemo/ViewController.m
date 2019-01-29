//
//  ViewController.m
//  SNExceptionGuarderDemo
//
//  Created by Ning Sun on 2019/1/29.
//  Copyright © 2019 Ning Sun. All rights reserved.
//

#import "ViewController.h"

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

- (IBAction)testArr:(id)sender {
    NSArray *test = @[];
    NSLog(@"object:%@",[test objectAtIndex:1]);
}

- (IBAction)testDict:(id)sender {
    id value = nil;
    NSDictionary *dic = @{@"key":value};
    NSLog(@"dic:%@",dic);
}

- (IBAction)testMutStr:(id)sender {
    id value = nil;
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"123"];
    [str appendString:value];
}

- (IBAction)testUnRecognized:(id)sender {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [NSObject performSelector:@selector(test)];
    NSObject *obj = [[NSObject alloc] init];
    [obj performSelector:@selector(test)];
#pragma clang diagnostic pop
}

@end
