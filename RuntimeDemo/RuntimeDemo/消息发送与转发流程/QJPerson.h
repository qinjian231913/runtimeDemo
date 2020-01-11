//
//  QJPerson.h
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QJPerson : NSObject

// 声明一个方法但没有实现，用于测试动态方法解析
- (int)addNum1:(int)num1 andNum2:(int)num2;

// 用于测试消息转发
- (void)study;

// 用于测试方法签名和转发
- (void)signatureTest;

// 用于测试类对象的动态方法解析
+ (void)classTest1;

// 用于测试类对象的消息转发
+ (void)classTest2;

// 用于测试类对象的方法签名和转发
+ (void)classTest3;

@end

NS_ASSUME_NONNULL_END
