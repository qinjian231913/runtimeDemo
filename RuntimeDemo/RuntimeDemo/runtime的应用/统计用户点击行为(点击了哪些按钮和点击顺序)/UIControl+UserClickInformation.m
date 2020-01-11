//
//  UIControl+UserClickInformation.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIControl+UserClickInformation.h"
#import <objc/runtime.h>
#import "UserClickInfoManager.h"

@implementation UIControl (UserClickInformation)

// 当我们点击一个UIButton时，其底层其实是调用的sendAction:to:forEvent:方法
// 所以我们在这里hook掉这个方法个
+ (void)load{
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(qj_sendAction:to:forEvent:));
    
    method_exchangeImplementations(method1, method2);
}

- (void)qj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    // 不影响原来类的调用
    [self qj_sendAction:action to:target forEvent:event];
    
    if ([self isMemberOfClass:[UIButton class]]) { // 只记录UIButton的点击事件
//        NSLog(@"%@ 调用 %@",target,NSStringFromSelector(action));
        NSString *clickInformation = [NSString stringWithFormat:@"%@ %@ 调用 %@",[NSDate date],target,NSStringFromSelector(action)];
        [UserClickInfoManager addOneClickInfo:clickInformation];
    }
    
}

@end
