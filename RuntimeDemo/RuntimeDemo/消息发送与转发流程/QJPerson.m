//
//  QJPerson.m
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "QJPerson.h"
#import <objc/runtime.h>
#import "QJCat.h"

@implementation QJPerson

#pragma mark - 动态方法解析
// OC方法
- (int)addNumA:(int)numA andNumB:(int)numB{
    NSLog(@"OC方法---%s",__func__);
    return numA + numB;
}

// C函数，注意添加的C函数需要的前面2个参数是默认的，后面的参数才是我们实际传的参数
int addTwoNum(id self , SEL _cmd , int a , int b){
    NSLog(@"C方法--%s",__func__);
    return a + b;
}


// 开发者要自己实现这个方法
// 在这个方法个中给类添加一个已经实现了的方法(添加的方法是要和调用的方法的返回值和参数类型一致)
// 添加的方法可以是OC方法个，也可以是C函数，只是获取IMP的方法不同
+(BOOL)resolveInstanceMethod:(SEL)sel{
    
    if (sel == @selector(addNum1:andNum2:)) {
        // OC方法的IMP（因为是类方法，所以self就是当前的类对象）
//        IMP imp = class_getMethodImplementation(self, @selector(addNumA:andNumB:));
        
        // C函数的IMP（C语言函数名可以强转为IMP）
        IMP imp = (IMP)addTwoNum;

        Method method = class_getInstanceMethod(self, @selector(addNumA:andNumB:));
        
        // 给类添加一个方法
        // 第一个参数：添加方法的类对象
        // 第二个参数：添加方法的名字
        // 第三个参数：函数地址(IMP)
        // 第四个参数：方法的返回值和参数类型
        class_addMethod(self, sel, imp, method_getTypeEncoding(method));
        
        // 如果动态添加了方法就返回YES，否则返回NO（实际上这个返回值没什么用）
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

#pragma mark - 消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(study)) {
        // 如果某个类中实现了一个和被调用方法同名的方法，这里就可以返回这个类的一个实例对象(比如QJCat中实现了study方法，所以这里返回一个QJCat的实例对象)
        // 注意这里如果返回nil或者返回的实例对象的类中并没有实现这个方法，那就会进入下一个阶段，也就是方法签名和转发流程
        return [NSClassFromString(@"QJCat") new];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

#pragma - 方法签名和转发
// 返回一个方法签名（所谓方法签名就是封装了方法的返回值和参数类型）
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(signatureTest)) { // 两种方式生成方法签名
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        
//        return [[QJCat new] methodSignatureForSelector:aSelector];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// NSInvocation封装了一个方法调用，包括：方法调用者、方法名、方法参数
//    anInvocation.target 方法调用者
//    anInvocation.selector 方法名
//    [anInvocation getArgument:NULL atIndex:0]
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    [anInvocation invokeWithTarget:[QJCat new]];
}

#pragma mark - 类对象的动态方法解析
+ (BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(classTest1)) {
        // 对于类方法，下面API要传入的是元类对象
        Class metaClass = object_getClass(self);
        
        IMP imp = class_getMethodImplementation(metaClass, @selector(addClassTest1));
        Method method = class_getClassMethod(metaClass, @selector(addClassTest1));
        
        class_addMethod(metaClass, sel, imp, method_getTypeEncoding(method));
    }
    return [super resolveClassMethod:sel];
}

+ (void)addClassTest1{
    NSLog(@"测试类对象的动态方法解析");
}

#pragma mark - 类对象的消息转发
+ (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(classTest2)) {
        // 这里是返回一个类对象
        return [QJCat class];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 类对象的方法签名和转发
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(classTest3)) {
        return [[QJCat class] methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s<##>",__func__);
    [anInvocation invokeWithTarget:[QJCat class]];
}

@end
