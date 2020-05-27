//
//  UILabelShowViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "UILabelShowViewController.h"
#import "CustomTopLabel.h"
#import "NSString+Custom.h"
#import "UILabel+Custom.h"

@interface UILabelShowViewController ()

@end

@implementation UILabelShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI {
    CustomTopLabel *label = [[CustomTopLabel alloc]initWithFrame:CGRectMake(100, 100, 100, 20)];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"顶部对齐文字";
    [self.view addSubview:label];
    
    UILabel *savelabel = [[UILabel alloc]init];
    savelabel.numberOfLines = 0;
    savelabel.font = [UIFont systemFontOfSize:13];
    savelabel.textColor = @"#999999".toColor;
    [self.view addSubview:savelabel];
    [savelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.offset(200);
        make.height.offset(40);
    }];
    
    [savelabel layoutIfNeeded];
    NSLog(@"savelabel.width:%f",savelabel.width);
    [savelabel showEndMessage:@"张三李四发理念尴尬阿朗falngalngalngalgalngalgnlnw我按功能发廊" lastTitle:@"保留文字"];
    
    NSInteger i = 100;
    
    NSLog(@"%ld",(long)i);
    
    NSInteger a = i;
    NSLog(@"%ld",(long)a);
    for(NSInteger p = 0;p< 10;p++){
        NSLog(@"%ld",(long)p);
    }
    UILabel *gonaf;
    [gonaf removeFromSuperview];

}
@end
