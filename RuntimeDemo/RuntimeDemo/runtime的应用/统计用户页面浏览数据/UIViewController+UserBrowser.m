//
//  UIViewController+UserBrowser.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "UIViewController+UserBrowser.h"
#import <objc/runtime.h>
#import "UserBrowserInformationManager.h"

@implementation UIViewController (UserBrowser)

+(void)load{
    // 交换viewWillAppear方法
    Method method1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method method2 = class_getInstanceMethod(self, @selector(qj_viewWillAppear:));
    method_exchangeImplementations(method1, method2);
    
    // 交换iewWillDisappear方法
    Method method3 = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    Method method4 = class_getInstanceMethod(self, @selector(qj_viewWillDisappear:));
    method_exchangeImplementations(method3, method4);
}

- (void)qj_viewWillAppear:(BOOL)animated{
    // 不影响原来类的调用
    [self qj_viewWillAppear:animated];
    
    NSString *informationString = [NSString stringWithFormat:@"%@：进入 %@",[NSDate date],[self class]];
    [UserBrowserInformationManager addOneBrowserInfo:informationString];
}

- (void)qj_viewWillDisappear:(BOOL)animated{
    // 不影响原来类的调用
    [self qj_viewWillDisappear:animated];
    
    NSString *informationString = [NSString stringWithFormat:@"%@：离开 %@",[NSDate date],[self class]];
    [UserBrowserInformationManager addOneBrowserInfo:informationString];
}

@end
