//
//  MJRefreshViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/8/13.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "MJRefreshViewController.h"
#import <MJRefresh.h>

@interface MJRefreshViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation MJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textColor = @"#000000".toColor;
    return cell;
}

#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
    headView.backgroundColor = @"#ffffff".toColor;
    
    UILabel *rankLabel = [[UILabel alloc]init];
    rankLabel.text = @"名次";
    rankLabel.font = [UIFont systemFontOfSize:12];
    rankLabel.textColor = @"#757575".toColor;
    [headView addSubview:rankLabel];
    [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(23);
        make.centerY.mas_equalTo(0);
    }];
    
    return headView;
}

-(void)makeTableView{
    self.tableView = [[UITableView alloc]init];
    [self.tableView setFrame:CGRectMake(0, 60, self.view.width,self.view.height - 60)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)loadNewData{
    [self.tableView reloadData];
}

@end
