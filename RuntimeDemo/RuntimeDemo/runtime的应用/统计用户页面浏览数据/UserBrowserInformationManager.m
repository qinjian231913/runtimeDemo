//
//  UserBrowserInformationManager.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UserBrowserInformationManager.h"

static UserBrowserInformationManager *manager = nil;

@implementation UserBrowserInformationManager
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserBrowserInformationManager alloc] init];
        manager.browserInformationArr = [NSMutableArray array];
    });
    
    return manager;
}

+ (void)addOneBrowserInfo:(NSString *)infomationString{
    if (infomationString.length) {
        NSMutableArray *temArray = [UserBrowserInformationManager shareInstance].browserInformationArr;
        [temArray addObject:[NSString stringWithFormat:@"%ld：%@",temArray.count,infomationString]];
    }
    
}

// 获取所有用户点击数据
+ (NSString *)getAllBrowserInfomations{
    return [[UserBrowserInformationManager shareInstance].browserInformationArr componentsJoinedByString:@"\n"];
}

@end
