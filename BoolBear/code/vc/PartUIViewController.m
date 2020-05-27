//
//  PartUIViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/5/11.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "PartUIViewController.h"

@interface PartUIViewController ()

@end

@implementation PartUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *cornerView = [[UIView alloc]initWithFrame:CGRectMake(20, 120, 100, 50)];
    cornerView.backgroundColor = @"#999999".toColor;
    [self.view addSubview:cornerView];
    
    CGRect rect = cornerView.bounds;
    CGSize radio = CGSizeMake(10, 10);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;//这只圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = cornerView.bounds;
    masklayer.path = path.CGPath;//设置路径
    cornerView.layer.mask = masklayer;
}

@end
