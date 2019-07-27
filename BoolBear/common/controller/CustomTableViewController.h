//
//  CustomTableViewController.h
//  BoolBear
//
//  Created by RuqiangLiu on 2018/7/14.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNaviationBarView.h"

@interface CustomTableViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)CustomNaviationBarView *navigationBar;

@end
