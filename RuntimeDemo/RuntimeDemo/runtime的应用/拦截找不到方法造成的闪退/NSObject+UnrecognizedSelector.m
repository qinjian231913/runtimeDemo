//
//  NSObject+UnrecognizedSelector.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "NSObject+UnrecognizedSelector.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

@implementation NSObject (UnrecognizedSelector)

#pragma mark - 实例方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 能走到这一步说明是没有找到方法实现。可以把找不到的方法和调用栈信息保存文件上传服务器以供开发者进行错误调试，同时又不会造成闪退
- (void)forwardInvocation:(NSInvocation *)anInvocation{

    NSString *errorInfo = [NSString stringWithFormat:@"\n\n时间：%@\n\n错误：%@找不到方法%@\n\n函数调用栈：\n%@",
                           [NSDate date],
                           anInvocation.target,
                           NSStringFromSelector(anInvocation.selector),
                           [self stackInfo]];
    NSLog(@"%@",errorInfo);
}

#pragma mark - 类方法
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 能走到这一步说明是没有找到方法实现。可以把找不到的方法和调用栈信息保存文件上传服务器以供开发者进行错误调试，同时又不会造成闪退
+ (void)forwardInvocation:(NSInvocation *)anInvocation{

    NSString *errorInfo = [NSString stringWithFormat:@"\n\n时间：%@\n\n错误：%@找不到方法%@\n\n函数调用栈：\n%@",
                           [NSDate date],
                           anInvocation.target,
                           NSStringFromSelector(anInvocation.selector),
                           [self stackInfo]];
    NSLog(@"%@",errorInfo);
}

// 获取函数调用栈信息
- (NSString *)stackInfo{
    
    NSArray *syms = [NSThread  callStackSymbols];
    
    return [syms componentsJoinedByString:@"\n"];
}

@end
