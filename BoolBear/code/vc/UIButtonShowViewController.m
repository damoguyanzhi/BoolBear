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
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12],NSFontAttributeName,nil];
    CGSize size = [@"左图右字" boundingRectWithSize:CGSizeMake(200, 20) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:tdic context:nil].size;
    
    CGFloat distance = 20;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 300,16 + distance + size.width, 45)];
    btn2.backgroundColor = [UIColor redColor];
    
    [btn2 setTitle:@"左图右字" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"cloudTeach_button_close"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, distance, 0, 0)];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:btn2];
}

@end
