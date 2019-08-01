//
//  CustomNavigationViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "CustomNavigationViewController.h"

@interface CustomNavigationViewController ()


@end

@implementation CustomNavigationViewController

#pragma mark - lifecycle (生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
}

#pragma mark - delegate (每一种代理 mark一次)
#pragma mark - event (事件)

-(void)clickLeft:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - network
#pragma mark - override (重写父类的方法)
#pragma mark - public method
#pragma mark - private method

- (void)makeUI {
    _navigationView = [[CustomNaviationBarView alloc]init];
    [_navigationView.leftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navigationView];
}

#pragma mark - setter getter


@end
