//
//  ViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2018/5/4.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import "MainViewController.h"
#import "NumberTool.h"
#import "MainTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat a = 5.96846;
    NSLog(@"%@",[NumberTool notRounding:a afterPoint:8]);
    self.navigationController.title = @"主功能";
    
    MainTableViewController *vc = [[MainTableViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
