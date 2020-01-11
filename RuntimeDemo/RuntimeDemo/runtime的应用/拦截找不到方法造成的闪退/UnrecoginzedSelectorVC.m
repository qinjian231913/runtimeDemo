//
//  UnrecoginzedSelectorVC.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UnrecoginzedSelectorVC.h"

@interface UnrecoginzedSelectorVC ()

- (void)instanceMethodTest;
+ (void)classMethodTest;

@end

@implementation UnrecoginzedSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"拦截找不到方法造成的闪退";

    [self setData];
    [self setUIWithColumnNum:1];
    
}

- (void)setData{
    self.btnTitleArr = @[@"测试调用没有实现的实例方法", @"测试调用没有实现的类方法"];
    
    self.btnFunArr = @[@"test1",@"test2"];
}

// 测试调用没有实现的实例方法
- (void)test1{
    [self instanceMethodTest];
}

// 测试调用没有实现的类方法
- (void)test2{
    [UnrecoginzedSelectorVC classMethodTest];
}

@end
