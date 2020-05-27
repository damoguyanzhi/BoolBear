//
//  CircleViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/5/26.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "CircleViewController.h"
#import "XLCircleColorView.h"
#import "XLStudyAreaTipView.h"
#import "XLPieChartView.h"
#import "XLPieChartModel.h"

@interface CircleViewController ()

@property(nonatomic,strong)XLCircleColorView *colorView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = @"#e5e5e5".toColor;
    NSArray *array =@[@[@"#000000",@"#cccccc"],@[@"#FF5858",@"#FAAD3E"],@[@"#19B4E1",@"#71D3A1"]];
    NSString *begin = array[0][0];
    NSString *end = array[0][1];
    self.colorView.beginColor = begin;
    self.colorView.endColor = end;
    self.colorView.percent = 0.3;
    self.colorView.lineGap = kCGLineCapButt;
    [self.colorView draw];

    XLStudyAreaTipView *tipView = [[XLStudyAreaTipView alloc]initWithFrame:CGRectMake(150, 50, 100, 30) text:@"测试数据" arrowRectRight:10];
    [self.view addSubview:tipView];
    
    
    self.dataArray = [[NSMutableArray alloc]init];
    NSArray *color = @[@"#000000",@"111111",@"222222",@"333333",@"444444",@"555555"];
    for(NSInteger i = 0;i<color.count;i++){
        NSString *msg = [NSString stringWithFormat:@"%ld",i+1];
        XLPieChartModel *model = [[XLPieChartModel alloc] init];
        model.rate = 0.2;
        model.name = msg;
        NSString *colorMsg = [NSString stringWithFormat:@"%@",color[i]];
        model.color = colorMsg.toColor;
        [self.dataArray addObject:model];
    }
    
    XLPieChartView *chart = [[XLPieChartView alloc] initWithFrame:CGRectMake(20, 340, self.view.width - 33, 225)];
    [self.view addSubview:chart];
    chart.dataArray = self.dataArray;
}


-(XLCircleColorView *)colorView{
    if(_colorView == nil){
        XLCircleColorView *view = [[XLCircleColorView alloc]initWithFrame:CGRectMake(20, 107, 150, 150)];
        [self.view addSubview:view];
        _colorView = view;
    }
    return _colorView;
}

@end
