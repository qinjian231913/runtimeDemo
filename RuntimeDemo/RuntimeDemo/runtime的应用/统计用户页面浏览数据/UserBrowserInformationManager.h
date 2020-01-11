//
//  UserBrowserInformationManager.h
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserBrowserInformationManager : NSObject

@property (nonatomic , strong) NSMutableArray *browserInformationArr; // 用户浏览页面数据数组

+ (instancetype)shareInstance;

// 记录一条浏览
+ (void)addOneBrowserInfo:(NSString *)infomationString;

// 获取所有用户浏览页面数据
+ (NSString *)getAllBrowserInfomations;

@end

NS_ASSUME_NONNULL_END
