//
//  StatistalUserClickVC.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "StatistalUserClickVC.h"
#import "UserClickInfoManager.h"

@interface StatistalUserClickVC ()

@end

@implementation StatistalUserClickVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"统计用户点击行为";
    [self setData];
    [self setUIWithColumnNum:1];
    
}

- (void)setData{
    self.btnTitleArr = @[@"打印统计的用户点击行为信息"];
    
    self.btnFunArr = @[@"printInfo"];
}

- (void)printInfo{
    
    NSLog(@"\n%@",[UserClickInfoManager getAllClickInfomations]);
}

@end
