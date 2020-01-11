//
//  QJCat.m
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "QJCat.h"

@implementation QJCat

- (void)study{
    NSLog(@"测试消息转发--%s",__func__);
}

- (void)signatureTest{
    NSLog(@"测试方法签名和转发--%s",__func__);
}

+ (void)classTest2{
    NSLog(@"测试类对象消息转发--%s",__func__);
}

+ (void)classTest3{
    NSLog(@"测试类对象的方法签名和转发--%s",__func__);
}

@end
