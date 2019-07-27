//
//  CustomTableViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2018/7/14.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import "CustomTableViewController.h"
#import "UIButtonShowViewController.h"
#import "UILabelShowViewController.h"

@interface CustomTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CustomTableViewController

#pragma mark - lifecycle (生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeUI];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = self.dataArray[indexPath.row];
    if([type isEqualToString:@"UIButton"]){
        [self.navigationController pushViewController:[[UIButtonShowViewController alloc]init] animated:YES];
    }else if([type isEqualToString:@"UIlabel"]){
        [self.navigationController pushViewController:[[UILabelShowViewController alloc]init] animated:YES];
    }
}

#pragma mark - event (事件)

-(void)clickLeft:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - network
#pragma mark - override (重写父类的方法)
#pragma mark - public method
#pragma mark - private method

-(void)makeUI{
    _navigationBar = [[CustomNaviationBarView alloc]init];
    [self.view addSubview:_navigationBar];
    [_navigationBar.leftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.navigationBar.frame.size.height) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - setter getter

@end
