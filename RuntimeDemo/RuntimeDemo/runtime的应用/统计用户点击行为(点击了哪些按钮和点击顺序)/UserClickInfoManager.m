//
//  UserClickInfoManager.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UserClickInfoManager.h"

static UserClickInfoManager *manager = nil;

@implementation UserClickInfoManager

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserClickInfoManager alloc] init];
        manager.clickInformationArr = [NSMutableArray array];
    });
    
    return manager;
}

+ (void)addOneClickInfo:(NSString *)infomationString{
    if (infomationString.length) {
        NSMutableArray *temArray = [UserClickInfoManager shareInstance].clickInformationArr;
        [temArray addObject:[NSString stringWithFormat:@"%ld：%@",temArray.count,infomationString]];
    }
    
}

// 获取所有用户点击数据
+ (NSString *)getAllClickInfomations{
    return [[UserClickInfoManager shareInstance].clickInformationArr componentsJoinedByString:@"\n"];
}

@end
