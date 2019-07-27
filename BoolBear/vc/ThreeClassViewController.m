//
//  ThreeClassViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/6/24.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "ThreeClassViewController.h"
#import "MJExtensionClassViewController.h"
#import "ClickPartInUILabelViewController.h"
#import "GetUIlabelIndexViewController.h"

@interface ThreeClassViewController ()

@end

@implementation ThreeClassViewController

#pragma mark - lifecycle (生命周期)

- (void)viewDidLoad {
    [super viewDidLoad];
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
    if([type isEqualToString:@"MjExtension"]){
        [self.navigationController pushViewController:[[MJExtensionClassViewController alloc]init] animated:YES];
    }else if([type isEqualToString:@"ClickPartInUILabel"]){
        [self.navigationController pushViewController:[[ClickPartInUILabelViewController alloc]init] animated:YES];
    }else if([type isEqualToString:@"GetUIlabelIndexViewController"]){
        [self.navigationController pushViewController:[[GetUIlabelIndexViewController alloc]init] animated:YES];
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

#pragma mark - setter getter


@end
