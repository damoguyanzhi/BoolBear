//
//  LabelHeightViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/30.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "LabelHeightViewController.h"

@interface LabelHeightViewController ()

@property(nonatomic,copy)NSString *message;

@property(nonatomic,strong)UIScrollView *scrollView;

@end

@implementation LabelHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [CommonData defaultConfig].navigationBarHeight, self.view.width,self.view.height - [CommonData defaultConfig].navigationBarHeight)];
    self.scrollView.contentSize = CGSizeMake(self.view.width, self.view.height - [CommonData defaultConfig].navigationBarHeight);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    self.message = @"sizeThatFits 安咖喱咖喱给拿了个拿过来哪敢了那个拿来跟那个了那个12345678了那个来那个狼哪个 来那个狼浪阿鲁高,Today is a fine day安咖喱咖喱给拿了个拿过来哪敢了那个拿来跟那个了那个了那个来那个狼哪个 来那个狼浪阿鲁高234567890";
    [self addSizeThatFits];
    [self addSiztToFit];
    [self sizeWithAttributes];
    [self boundingRectWithSize];
}

-(void)addSizeThatFits{
   
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, self.view.width - 20, 20)];
    testLabel.backgroundColor = @"#000000".toFullColor(0.3);
    testLabel.font = [UIFont systemFontOfSize:12];
    testLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:self.message];
    [attributedMessage setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(0, 10)];
    [attributedMessage setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(50, 10)];
    [attributedMessage setAttributes:@{NSForegroundColorAttributeName:@"#cccccc".toColor} range:NSMakeRange(30, 10)];
    testLabel.attributedText = attributedMessage;
    
    CGSize size = [testLabel sizeThatFits:CGSizeMake(self.view.width - 20, 20)];
    testLabel.size = size;
    NSLog(@"size = %@", NSStringFromCGSize(size));
    [self.scrollView addSubview:testLabel];
}

-(void)addSiztToFit{
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, self.view.width - 20, 20)];
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:self.message];
    [attributedMessage setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} range:NSMakeRange(0, 10)];
    [attributedMessage setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(50, 10)];
    [attributedMessage setAttributes:@{NSForegroundColorAttributeName:@"#cccccc".toColor} range:NSMakeRange(30, 10)];
    testLabel.attributedText = attributedMessage;
    testLabel.numberOfLines = 0;
    testLabel.font = [UIFont systemFontOfSize:12];
    testLabel.attributedText = attributedMessage;
    [testLabel sizeToFit];
    NSLog(@"size = %@", NSStringFromCGSize(testLabel.frame.size));
    [self.scrollView addSubview:testLabel];
}

-(void)sizeWithAttributes{
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = [self.message sizeWithAttributes:@{
                                             NSFontAttributeName : font
                                             }];
    NSLog(@"size = %@", NSStringFromCGSize(size));
    size.width = size.width > self.view.width - 20?self.view.width - 20:size.width;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 300, self.view.width - 20, 20)];
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:self.message];
    [attributedMessage setAttributes:@{NSForegroundColorAttributeName:@"#cccccc".toColor} range:NSMakeRange(30, 10)];
    label.numberOfLines = 0;
    label.attributedText = attributedMessage;
    label.size = size;
    [self.scrollView addSubview:label];
    NSLog(@"size = %@", NSStringFromCGSize(label.size));
}

-(void)boundingRectWithSize{
    UIFont *font = [UIFont systemFontOfSize:30];
    CGRect suggestedRect = [self.message boundingRectWithSize:CGSizeMake(self.view.width - 20, MAXFLOAT)
                                              options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName : font }
                                              context:nil];
    NSLog(@"size = %@", NSStringFromCGSize(suggestedRect.size));
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 400, self.view.width - 20, 20)];
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:self.message];
    [attributedMessage setAttributes:@{NSForegroundColorAttributeName:@"#cccccc".toColor} range:NSMakeRange(30, 10)];
    label.numberOfLines = 0;
    label.font = font;
    label.attributedText = attributedMessage;
    label.size = suggestedRect.size;
    [self.scrollView addSubview:label];
    NSLog(@"size = %@", NSStringFromCGSize(label.size));
}

@end
