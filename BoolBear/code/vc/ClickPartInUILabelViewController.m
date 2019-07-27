//
//  ClickPartInUILabelViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/23.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "ClickPartInUILabelViewController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "Masonry.h"

@interface ClickPartInUILabelViewController ()<YBAttributeTapActionDelegate>

@end

@implementation ClickPartInUILabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTestLabel2];
}

- (void)yb_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index{
    NSLog(@"%@%ld",string,(long)index);
}

-(void)addTestLabel2{
    //需要点击的字符不同
    NSString *label_text2 = @"您好！您是小明吗？你中奖了，领取地址“www.yb.com”,领奖码你中奖了，领取地址“www.yb.com”,领奖码收到";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(label_text2.length - 2, 2)];
//    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(label_text2.length - 2, 2)];
    
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f ]};
    CGRect infoRect = [label_text2 boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20, 100) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    
    UILabel *ybLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width - 20, infoRect.size.height)];
    ybLabel2.backgroundColor = [UIColor lightGrayColor];
    ybLabel2.numberOfLines = 0;
    ybLabel2.attributedText = attributedString2;
    [self.view addSubview:ybLabel2];
    [ybLabel2 yb_addAttributeTapActionWithStrings:@[@"收到"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
        NSLog(@"%@",message);
    }];
}

@end
