//
//  CircleViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/5/26.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "CircleViewController.h"
#import "XLCircleColorView.h"

@interface CircleViewController ()

@property(nonatomic,strong)XLCircleColorView *colorView;

@property(nonatomic,strong)XLCircleColorView *colorView2;

@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array =@[@[@"#000000",@"#cccccc"],@[@"#FF5858",@"#FAAD3E"],@[@"#19B4E1",@"#71D3A1"]];
    NSString *begin = array[0][0];
    NSString *end = array[0][1];
    self.colorView.beginColor = begin;
    self.colorView.endColor = end;
    self.colorView.percent = 0.3;
    self.colorView.lineGap = kCGLineCapButt;
    [self.colorView draw];
    
    self.colorView2.beginColor = begin;
    self.colorView2.endColor = end;
    self.colorView2.percent = 0.3;
    self.colorView2.lineGap = kCGLineCapSquare;
    [self.colorView draw];
}


-(XLCircleColorView *)colorView{
    if(_colorView == nil){
        XLCircleColorView *view = [[XLCircleColorView alloc]initWithFrame:CGRectMake(20, 107, 150, 150)];
        [self.view addSubview:view];
        _colorView = view;
    }
    return _colorView;
}

-(XLCircleColorView *)colorView2{
    if(_colorView2 == nil){
        XLCircleColorView *view = [[XLCircleColorView alloc]initWithFrame:CGRectMake(180, 107, 150, 150)];
        [self.view addSubview:view];
        _colorView2 = view;
    }
    return _colorView2;
}

@end
