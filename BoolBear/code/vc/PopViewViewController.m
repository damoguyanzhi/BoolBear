//
//  PopViewViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/7/13.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "PopViewViewController.h"
#import "XLSysGruidanceFilterView.h"

@interface PopViewViewController ()

@end

@implementation PopViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 60, 200, 30)];
    [button setTitle:@"弹出多级菜单" forState:UIControlStateNormal];
    [button setTitleColor:@"#000000".toColor forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickPop:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)clickPop:(UIButton *)button{
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for(NSInteger i = 0;i<10;i++){
        XLSysGruidanceFilterModel *model = [[XLSysGruidanceFilterModel alloc]init];
        model.sectionName = [NSString stringWithFormat:@"section%ld",(long)i];
        model.itemArray = [[NSMutableArray alloc]init];
        [dataArray addObject:model];
        
        for(NSInteger j = 0;j<10;j++){
            XLSysGruidanceFilterItemModel *itemModel = [[XLSysGruidanceFilterItemModel alloc]init];
            itemModel.id = [NSString stringWithFormat:@"%ld",(long)j];
            itemModel.name = [NSString stringWithFormat:@"item%ld",(long)j];
            [model.itemArray addObject:itemModel];
        }
    }

    [XLSysGruidanceFilterView showInView:dataArray currentView:button viewWidth:300 block:^(NSInteger sectionIndex, NSInteger rowIndex) {
        
    }];
}

@end
