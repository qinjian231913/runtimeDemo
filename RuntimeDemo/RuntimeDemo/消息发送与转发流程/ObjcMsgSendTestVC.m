//
//  ObjcMsgSendTestVC.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "ObjcMsgSendTestVC.h"
#import "QJPerson.h"
#import "QJCat.h"

@interface ObjcMsgSendTestVC ()

@end

@implementation ObjcMsgSendTestVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息发送与转发";
    
    [self setData];
    [self setUIWithColumnNum:1];
}

- (void)setData{
    self.btnTitleArr = @[@"实例对象方法动态解析",@"实例对象消息转发",@"实例对象方法签名和转发",
                         @"类对象方法动态解析",@"类对象消息转发",@"类对象方法签名和转发"];
    
    self.btnFunArr = @[@"objcMsgSendTestVC_test1",@"objcMsgSendTestVC_test2",@"objcMsgSendTestVC_test3",
                       @"objcMsgSendTestVC_test4",@"objcMsgSendTestVC_test5",@"objcMsgSendTestVC_test6"];
}

// 实例对象方法动态解析
- (void)objcMsgSendTestVC_test1{
    QJPerson *p = [QJPerson new];
    NSLog(@"%d",[p addNum1:12 andNum2:3]);
}

// 实例对象消息转发
- (void)objcMsgSendTestVC_test2{
    QJPerson *p = [QJPerson new];
    [p study];
}

// 实例对象方法签名和转发
- (void)objcMsgSendTestVC_test3{
    QJPerson *p = [QJPerson new];
    [p signatureTest];
}

// 类对象方法动态解析
- (void)objcMsgSendTestVC_test4{
    [QJPerson classTest1];
}

// 类对象消息转发
- (void)objcMsgSendTestVC_test5{
    [QJPerson classTest2];
}

// 类对象方法签名和转发
- (void)objcMsgSendTestVC_test6{
    [QJPerson classTest3];
}

@end
