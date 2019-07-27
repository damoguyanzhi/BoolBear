//
//  MainTableViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2018/7/14.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import "MainTableViewController.h"
#import "CustomTableViewController.h"
#import "ThreeClassViewController.h"
#import "CustomButton.h"
#import "DataModel.h"
#import "CommonData.h"

@interface MainTableViewController ()<UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MainTableViewController

-(void)viewDidAppear:(BOOL)animated{
    CGFloat tableHeight = self.view.frame.size.height - CommonTabBarHeight;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, tableHeight)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [DataModel defaultConfig].typeNameArray;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
   
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    if(!cell){
        cell = [tableView cellForRowAtIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewController *vc;
    if([[self.dataArray objectAtIndex:indexPath.row] isEqualToString:@"UI"]){
        vc = [[CustomTableViewController alloc]init];
        vc.dataArray = [DataModel defaultConfig].uiNameArray;
    }else if([[self.dataArray objectAtIndex:indexPath.row] isEqualToString:@"Tool"]){
        vc = [[CustomTableViewController alloc]init];
        vc.dataArray = [[NSMutableArray alloc]initWithObjects:@"NumberTool", nil];
    }else if([[self.dataArray objectAtIndex:indexPath.row] isEqualToString:@"第三方类demo"]){
        vc = [[ThreeClassViewController alloc]init];
        vc.dataArray = [[NSMutableArray alloc]initWithObjects:@"MjExtension",@"ClickPartInUILabel",@"GetUIlabelIndexViewController", nil];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

@end
