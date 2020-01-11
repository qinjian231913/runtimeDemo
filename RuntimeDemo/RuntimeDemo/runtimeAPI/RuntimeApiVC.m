//
//  RuntimeApiVC.m
//  RuntimeDemo
//
//  Created by TING on 11/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "RuntimeApiVC.h"
#import <objc/runtime.h>
#import "QJMen.h"
#import "QJWomen.h"

@interface RuntimeApiVC ()

@property (nonatomic , strong) QJMen *men;
@property (nonatomic , strong) QJWomen *women;
@end

@implementation RuntimeApiVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"runtime相关API";
    
    [self setData];
    [self setUIWithColumnNum:2];
}

- (void)setData{
    _men = [QJMen new];
    _women = [QJWomen new];
    
    self.btnTitleArr = @[@"isa和superclass指向的class",@"更改isa的指向",@"是否是类或元类对象",
                         @"获取成员变量信息",@"获取成员列表信息",@"设置/获取成员变量值",
                         @"动态生成类",@"动态添加成员变量",@"获取一个属性",
                         @"获取属性列表",@"动态添加属性",@"动态替换属性",
                         @"获取实例方法、类方法",@"获取返回值、参数类型信息",@"更改方法的函数地址",
                         @"方法交换",@"获取方法列表"];
    
    self.btnFunArr = @[@"apiTest1",@"apiTest2",@"apiTest3",
                       @"apiTest4",@"apiTest5",@"apiTest6",
                       @"apiTest7",@"apiTest8",@"apiTest9",
                       @"apiTest10",@"apiTest11",@"apiTest12",
                       @"apiTest13",@"apiTest14",@"apiTest15",
                       @"apiTest16",@"apiTest17"];
}

#pragma mark - 获取isa指向的class和superclass指向的class
- (void)apiTest1{
    // 获取isa指向的Class(也就是我们常用的获取一个实例对象的类或者获取一个类对象的元类)
    NSLog(@"men的isa指针-->%s",object_getClassName(_men));
    
    // 获取父类
    NSLog(@"Men的父类：%@",class_getSuperclass([_men class]));
    
}

#pragma mark - 更改isa的指向
- (void)apiTest2{
    // 设置isa指向的class
    object_setClass(_men, object_getClass(_women));
    NSLog(@"改变men的isa指针后再来调用方法看是调用的哪个类中的方法");
    [_men run];
}

#pragma mark - 判断是否是类对象或元类对象
- (void)apiTest3{
    // 判断一个对象是否是类对象
    NSLog(@"men是否是类对象：%d，[men class]是否是类对象：%d",object_isClass(_men),object_isClass([_men class]));
    
    // 判断一个类是否是元类
    NSLog(@"[men class]是否是元类:%d",class_isMetaClass([_men class]));
    NSLog(@"[[men class] class]是否是元类:%d",class_isMetaClass([[_men class] class]));
    NSLog(@"object_getClass([men class]是否是元类:%d",class_isMetaClass(object_getClass([_men class])));
}

#pragma mark - 获取成员变量信息
- (void)apiTest4{
    // 根据成员变量名获取成员变量(注意定义的属性默认生成的成员变量名都是带下划线的)
    Ivar ivar = class_getInstanceVariable([QJMen class], "_age");
    NSLog(@"获取成员变量的名字：%s",ivar_getName(ivar));
    NSLog(@"获取成员变量的编码类型：%s",ivar_getTypeEncoding(ivar));
    NSLog(@"获取成员变量的内存偏移：%td",ivar_getOffset(ivar));
}

#pragma mark - 获取成员列表信息
- (void)apiTest5{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([QJMen class], &count);
    
    NSLog(@"成员列表数量：%d",count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"%s",ivar_getName(ivar));
    }

    // 需要释放内存
    free(ivarList);
}

- (NSString *)ivarListNamesWithClass:(Class)cls{
    NSString *names = @"";
    
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        NSString *joinStr = names.length ? @" , " : @"";
        Ivar ivar = ivarList[i];
        names = [NSString stringWithFormat:@"%@%@%s",names,joinStr,ivar_getName(ivar)];
    }
    
    return names;
}

#pragma mark - 设置/获取成员变量值
- (void)apiTest6{
    // 获取成员变量
    Ivar ivar = class_getInstanceVariable([QJMen class], "_age");

    // 设置成员变量的值(注意不能设置或获取基本数据类型，可以转换成字符串再设置)
    object_setIvar(_men, ivar, @"33");

    // 获取成员变量的值
    NSLog(@"获取成员变量age的值：%d",[object_getIvar(_men, ivar) intValue]);
}

#pragma mark - 动态生成类
- (void)apiTest7{
    // 创建一个类，第一个参数是设置父类，第二个参数是生成类的名字
    Class chinessMenClass = objc_allocateClassPair([QJMen class], "ChinessMen", 0);

    // 将类注册到运行时环境(注意添加成员变量需要在注册之前完成，注册后是不能添加成员变量的)
    objc_registerClassPair(chinessMenClass);
    
    NSLog(@"%@",class_getSuperclass(chinessMenClass));
    
    // 销毁一个类
    objc_disposeClassPair(chinessMenClass);
}

#pragma mark - 动态添加成员变量
// 注意成员列表是只读的，所以只有在动态生成类并且在类注册之前才能添加成员变量
// 本来就有的类以及动态生成类时已经完成注册后就不能添加成员列表
- (void)apiTest8{
    // 先动态创建一个类
    Class chinessMenClass = objc_allocateClassPair([QJMen class], "ChinessMen", 0);
    
    // 给类添加成员变量
    BOOL result = class_addIvar(chinessMenClass, "_money", sizeof(int), 1, @encode(int));
    if (result) {
        NSLog(@"动态添加成员变量成功");
        NSLog(@"添加后的成员列表是：%@",[self ivarListNamesWithClass:chinessMenClass]);
        // 注册类
        objc_registerClassPair(chinessMenClass);
    }else{
        NSLog(@"动态添加成员变量失败");
    }
}

#pragma mark - 获取一个属性
- (void)apiTest9{
    // 传入一个属性名获类中的这个属性
    objc_property_t property = class_getProperty([QJMen class], "name");
    
    // 获取属性名
    NSLog(@"%s",property_getName(property));
    
    // 获取属性的属性信息，里面包含属性的类型、对应的成员变量等信息
    // 属性信息由3部分组成
    // 最前面的部分是T加上属性的类型(编码类型)，比如NSString类就是T@"NSString"，后面跟着逗号
    // 中间部分是属性的修饰符，比如QJMen的name属性是(nonatomic , strong)，nonatomic用N表示，strong用&表示，它们都用逗号隔开
    // 后面部分是V加上属性对应的成员变量的名字
// 具体的可以参考官方文档https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101)
    NSLog(@"%s",property_getAttributes(property));
    
    NSLog(@"%s",property_getAttributes(class_getProperty([QJMen class], "age")));
}

#pragma mark - 获取属性列表
- (void)apiTest10{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([QJMen class], &count);
    
    NSLog(@"属性数量：%d",count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        NSLog(@"%s,%s",property_getName(property),property_getAttributes(property));
    }
    
    free(propertyList);
}

#pragma mark - 动态添加属性
// 给QJMen添加一个属性@property (nonatomic , strong) NSString *phone;
- (void)apiTest11{
    objc_property_attribute_t type = {"T","@\"NSString\""};
    objc_property_attribute_t ownership = {"&","N"};
    objc_property_attribute_t backingivar = {"V","_phone"};
    objc_property_attribute_t attrs[3] = {type,ownership,backingivar};
    
    // 第一个参数是要添加property的类
    // 第二个参数是property的名字
    // 第三个参数是property的属性参数，是一个数组
    // 第四个参数是第三个参数数组的元素个数
    class_addProperty([QJMen class], "phone", attrs, 3);
    
    // 添加完属性后再打印属性列表
    [self apiTest10];
}

#pragma mark - 动态替换属性
// 将name属从字符串类型改为int类型
- (void)apiTest12{
    objc_property_attribute_t type = {"T","i"};
    objc_property_attribute_t ownership = {"","N"};
    objc_property_attribute_t backingivar = {"V","_name"};
    objc_property_attribute_t attrs[3] = {type,ownership,backingivar};
    
    // 第一个参数是property所属的类
    // 第二个参数是要替换的property的名字
    // 第三个参数是要替换的property的属性参数，是一个数组
    // 第四个参数是第三个参数数组的元素个数
    class_replaceProperty([QJMen class], "name", attrs, 3);
    // 添加完属性后再打印属性列表
    [self apiTest10];
}

#pragma mark - 获取实例方法、类方法
- (void)apiTest13{
    // 获取一个类方法
    Method classMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(classMethodTest));
    
    // 获取方法名
    NSLog(@"%@",NSStringFromSelector(method_getName(classMethod)));
    
    // 获取一个实例方法
    Method instanceMethod = class_getInstanceMethod([QJMen class], @selector(run));
    // 获取方法名
    NSLog(@"%@",NSStringFromSelector(method_getName(instanceMethod)));
    
    
}

#pragma mark - 获取返回值、参数类型信息
- (void)apiTest14{
    Method classMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(classMethodTest));

    // 获取返回值类型
    char returnType[10];
    method_getReturnType(classMethod, returnType, 10);
    NSLog(@"返回值类型-->%s",returnType);
    
    // 获取摸个参数的类型
    char argType[10];
    method_getArgumentType(classMethod, 0, argType, 10);
    NSLog(@"第一个参数类型-->%s",argType);
    
    // 获取返回值参数类型
    NSLog(@"返回值参数类型%s",method_getTypeEncoding(classMethod));
    
 
    
    // 设置/更改方法的函数地址
    
    // 获取参数个数
    NSLog(@"参数个数：%d",method_getNumberOfArguments(classMethod));
}

#pragma mark - 更改方法的函数地址
- (void)apiTest15{
    Method classMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(classMethodTest));
    
    Method anotherClassMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(anotherClassMethodTest));
    
    // 获取函数地址(IMP)
     IMP anotherImp = method_getImplementation(anotherClassMethod);
    
    // 更改一个方法的IMP
    method_setImplementation(classMethod, anotherImp);
    
    [QJMen classMethodTest];
}

#pragma mark - 方法交换
- (void)apiTest16{
    Method classMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(classMethodTest));
    
    Method anotherClassMethod = class_getClassMethod(object_getClass([QJMen class]), @selector(anotherClassMethodTest));
    
    // 交换2个方法个
    method_exchangeImplementations(classMethod, anotherClassMethod);
    
    [QJMen classMethodTest];
    [QJMen anotherClassMethodTest];
}

#pragma mark - 获取方法列表
- (void)apiTest17{
    // 类方法列表
    unsigned int classMethondCount;
    Method *classMethodList = class_copyMethodList(object_getClass([QJMen class]), &classMethondCount);
    NSLog(@"类方法个数：%d",classMethondCount);
    for (int i = 0; i < classMethondCount; i++) {
        Method method = classMethodList[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(method)));
    }
    
    NSLog(@"----------------");
    
    // 实例方法列表
    unsigned int isntanceMethondCount;
    Method *instanceMethodList = class_copyMethodList([QJMen class], &isntanceMethondCount);
    NSLog(@"实例方法个数：%d",isntanceMethondCount);
    for (int i = 0; i < isntanceMethondCount; i++) {
        Method method = instanceMethodList[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(method)));
    }
}

@end
