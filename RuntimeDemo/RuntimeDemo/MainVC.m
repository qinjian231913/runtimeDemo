//
//  MainVC.m
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "MainVC.h"
#import "ObjcMsgSendTestVC.h"
#import "RuntimeApiVC.h"
#import "UnrecoginzedSelectorVC.h"
#import "StatistalUserClickVC.h"
#import "UserBrowserInformationVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
    
    [self setData];
    [self setUIWithColumnNum:1];
    UINavigationController
}

- (void)setData{
    self.btnTitleArr = @[@"消息发送与转发流程", @"runtime相关API",@"拦截找不到方法造成的闪退",
                         @"统计用的点击行为",@"统计用户浏览页面行为"];
    
    self.btnFunArr = @[@"toObjcMsgSendTestVC",@"toRuntimeApiVC",@"toUnrecoginzedSelectorVC",
                       @"toStatistalUserClickVC",@"toUserBrowserInformationVC"];
}

// 消息发送与转发流程测试页面
- (void)toObjcMsgSendTestVC{
    ObjcMsgSendTestVC *vc = [[ObjcMsgSendTestVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// runtime相关API
- (void)toRuntimeApiVC{
    RuntimeApiVC *vc = [[RuntimeApiVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 拦截找不到方法造成的闪退
- (void)toUnrecoginzedSelectorVC{
    UnrecoginzedSelectorVC *vc = [[UnrecoginzedSelectorVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 统计用的点击行为
- (void)toStatistalUserClickVC{
    StatistalUserClickVC *vc = [[StatistalUserClickVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 统计用户浏览页面行为
- (void)toUserBrowserInformationVC{
    UserBrowserInformationVC *vc = [[UserBrowserInformationVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
