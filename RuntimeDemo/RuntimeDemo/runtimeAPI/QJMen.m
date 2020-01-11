//
//  QJMen.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "QJMen.h"

@implementation QJMen

+ (int)classMethodTest{
    NSLog(@"%s",__func__);
    return 10;
}

+ (int)anotherClassMethodTest{
    NSLog(@"%s",__func__);
    return 20;
}

- (void)run{
    NSLog(@"%s",__func__);
}

- (void)walk{
    NSLog(@"%s",__func__);
}

@end
