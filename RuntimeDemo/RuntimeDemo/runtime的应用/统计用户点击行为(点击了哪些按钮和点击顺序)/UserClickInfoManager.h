//
//  UserClickInfoManager.h
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserClickInfoManager : NSObject


@property (nonatomic , strong) NSMutableArray *clickInformationArr; // 用户点击行为数据数组

+ (instancetype)shareInstance;

// 记录一条点击信息
+ (void)addOneClickInfo:(NSString *)infomationString;

// 获取所有用户点击数据
+ (NSString *)getAllClickInfomations;

@end

NS_ASSUME_NONNULL_END
