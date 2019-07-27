//
//  UIButtonShowViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "UIButtonShowViewController.h"
#import "CustomButton.h"
#import "UIButton+Custom.h"
#import <Masonry.h>

@interface UIButtonShowViewController ()

@end

@implementation UIButtonShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomButton *button = [[CustomButton alloc]initWithFrame:CGRectMake(100, 100, 260, 45)];
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc]initWithString:@"上gaffef敌人名侠124"];
    [message addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
    [message addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, 3)];
    [button createButtonType:CustomButtonImageTop attributedString:message imageUrl:@"cloudTeach_button_close" gap:5 fontSize:12];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(200);
        make.top.offset(200);
    }];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 80, 45)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"上fa124" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"cloudTeach_button_close"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setButtonShowType:RSButtonTypeLabelLeft];
    [self.view addSubview:btn];
}

@end
