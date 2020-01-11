//
//  BaseVC.m
//  RuntimeDemo
//
//  Created by TING on 10/1/2020.
//  Copyright © 2020 SHENZHEN TITA INTERACTIVE TECHNOLOGY CO.,LTD. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)setUIWithColumnNum:(NSInteger)columnNum{
    if(columnNum <= 0) return;
    
    columnNum = MIN(columnNum, 2);
    
    CGFloat btnW = columnNum==2 ? 170 : 300;
    CGFloat btnH = 45;
    CGFloat btnSpace = (WIDTH - btnW * columnNum)/(columnNum+1);
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88, WIDTH, HEIGHT-88)];
    scrollView.contentSize = CGSizeMake(WIDTH, (self.btnFunArr.count/columnNum)*(btnH+30)+100);
    [self.view addSubview:scrollView];
    
    for (NSInteger i = 0; i < self.btnTitleArr.count; i++) {
        NSString *title = self.btnTitleArr[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnSpace+(btnW+btnSpace)*(i%columnNum), 30+(btnH+30)*(i/columnNum), btnW, btnH);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        btn.layer.borderColor = UIColor.blackColor.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = [UIFont systemFontOfSize:title.length>12?15:17];
        [scrollView addSubview:btn];
        [btn addTarget:self action:NSSelectorFromString(self.btnFunArr[i]) forControlEvents:UIControlEventTouchUpInside];
    }
}


@end
