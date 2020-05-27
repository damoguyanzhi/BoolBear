//
//  CompressionAndHuggingViewController.h
//  BoolBear
//
//  Created by RuqiangLiu on 2020/1/6.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "CompressionAndHuggingViewController.h"
#import <Masonry.h>

@interface CompressionAndHuggingViewController ()

@property (nonatomic, weak) UILabel * label1;

@property (nonatomic, weak) UILabel * label2;

@property (nonatomic, weak) UILabel * label3;

@end

@implementation CompressionAndHuggingViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUI1];
    self.view.backgroundColor = [UIColor whiteColor];
    _label1.text = @"张发给发给";
    _label2.text = @"脏了发浪浪浪兰陵古娜拉你敢来给你";
    _label3.text = @"2019.12.22";
}

- (void)setUI1{
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.textColor = @"#212121".toColor;
    label1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label1];
    _label1 = label1;
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(10);
    }];
    
    [label1 setContentCompressionResistancePriority:758 forAxis:(UILayoutConstraintAxisHorizontal)];
    [label1 setContentHuggingPriority:300 forAxis:(UILayoutConstraintAxisHorizontal)];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = @"#757575".toColor;
    label2.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label2];
    _label2 = label2;
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(8);
        make.width.greaterThanOrEqualTo(@80).priority(759);
        make.top.equalTo(label1.mas_top);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.textColor = @"#757575".toColor;
    label3.textAlignment = NSTextAlignmentRight;
    label3.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label3];
    _label3 = label3;
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.left.equalTo(label2.mas_right).offset(2);
        make.top.equalTo(label1.mas_top);
    }];
    [label3 setContentCompressionResistancePriority:760 forAxis:(UILayoutConstraintAxisHorizontal)];
}

@end
