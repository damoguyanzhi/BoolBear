//
//  DragTableViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/6/11.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "DragTableViewController.h"
#import "ShowModel.h"

@interface DragTableViewController ()

@property(nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation DragTableViewController

- (void)viewDidLoad {
    self.dataArray = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    for(NSInteger i = 0;i<20;i++){
        ShowSonModel *model = [[ShowSonModel alloc]init];
        model.type = [NSString stringWithFormat:@"测试%ld",(long)i];
        model.exampleVC = nil;
        [self.dataArray addObject:model];
    }
    
    WS(weakSelf, self);
    [self.tableView setDataWithArray:self.dataArray withBlock:^(NSMutableArray *newArray) {
        weakSelf.dataArray = newArray;
    }];
}

@end
