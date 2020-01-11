//
//  UserBrowserInformationVC.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UserBrowserInformationVC.h"
#import "UserBrowserInformationManager.h"

@interface UserBrowserInformationVC ()

@end

@implementation UserBrowserInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"统计用户页面浏览数据";
    [self setData];
    [self setUIWithColumnNum:1];
    
}

- (void)setData{
    self.btnTitleArr = @[@"统计用户页面浏览数据"];
    
    self.btnFunArr = @[@"printInfo"];
}

- (void)printInfo{
    
    NSLog(@"\n%@",[UserBrowserInformationManager getAllBrowserInfomations]);
}

@end
