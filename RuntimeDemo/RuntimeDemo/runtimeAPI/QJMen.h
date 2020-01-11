//
//  QJMen.h
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QJMen : NSObject

@property (nonatomic , assign) int age;
@property (nonatomic , strong) NSString *name;

+ (int)classMethodTest;
+ (int)anotherClassMethodTest;

- (void)run;
- (void)walk;

@end

NS_ASSUME_NONNULL_END
