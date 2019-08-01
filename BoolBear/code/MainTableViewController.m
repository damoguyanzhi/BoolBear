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
#import "ShowModel.h"
#import <MJExtension.h>
@interface MainTableViewController ()<UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)ShowModel *model;

@end

@implementation MainTableViewController

-(void)viewDidAppear:(BOOL)animated{
    CGFloat tableHeight = self.view.frame.size.height - CommonTabBarHeight;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, tableHeight)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self loadConfigJson];
}

-(void)loadConfigJson{
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"show" ofType:@"geojson"];
    NSString *parseJason = [[NSString alloc] initWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[parseJason dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    self.model = [ShowModel mj_objectWithKeyValues:dict[@"firstShow"]];
    self.dataArray = [self.model.typeList mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count > 0?self.dataArray.count:0;
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
    ShowTypeModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.type;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewController *vc;
    ShowTypeModel *model = self.dataArray[indexPath.row];
    vc = [[CustomTableViewController alloc]init];
    vc.dataArray = [model.sonContent mutableCopy];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
