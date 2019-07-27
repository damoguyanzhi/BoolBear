//
//  GetUIlabelIndexViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/24.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "GetUIlabelIndexViewController.h"
#import "CharacterLocationSeeker.h"

@interface GetUIlabelIndexViewController ()

@property(nonatomic,strong)UIButton *modifyButton;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)CharacterLocationSeeker *locationSeeker;

@end

@implementation GetUIlabelIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTestLabel];
}

-(void)clickModifyButton:(UIButton *)button{
    NSLog(@"clickModifyButton");
}

-(void)addTestLabel{
    
    NSString *message = @"你说说看看有没有什么可以用的扼杀了归纳格拉刚了奥利给哪敢奥利给囊，你说说看看有没有什么可以用的扼杀了归纳格拉刚了奥利给哪敢奥利给囊";
    CGSize infoSize = CGSizeMake(self.view.frame.size.width - 30,MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f ]};
    CGRect titleSize = [message boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:message];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(message.length - 2, 2)];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, self.view.frame.size.width - 30, titleSize.size.height)];
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor grayColor];
    self.label.numberOfLines = 0;
    
    
    self.label.attributedText = attributedString;
    [self.label setFrame:CGRectMake(15, 100, self.view.frame.size.width - 30, titleSize.size.height)];
    
    [self.view addSubview:self.label];
    self.locationSeeker = [[CharacterLocationSeeker alloc]init];
    [self.locationSeeker configWithLabel:self.label];
    CGRect rect = [self.locationSeeker characterRectAtIndex:message.length - 2];
    
    [self changeModifyButton];
    [self.modifyButton setFrame:CGRectMake(self.label.frame.origin.x + rect.origin.x - 5, self.label.frame.origin.y + rect.origin.y - 5, 30, 30)];
}

-(void)changeModifyButton{
    if(_modifyButton == nil){
        self.modifyButton = [[UIButton alloc]init];
        [self.modifyButton addTarget:self action:@selector(clickModifyButton:) forControlEvents:UIControlEventTouchUpInside];
        self.modifyButton.backgroundColor = [UIColor redColor];
        self.modifyButton.alpha = 0.5;
        [self.view addSubview:self.modifyButton];
    }
}

@end
