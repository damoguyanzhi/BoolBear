//
//  UILabelShowViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "UILabelShowViewController.h"
#import "CustomTopLabel.h"

@interface UILabelShowViewController ()

@end

@implementation UILabelShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    CustomTopLabel *label = [[CustomTopLabel alloc]initWithFrame:CGRectMake(100, 100, 100, 20)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"顶部对齐文字";
    [self.view addSubview:label];
}

@end
