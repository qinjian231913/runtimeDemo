//
//  main.m
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
