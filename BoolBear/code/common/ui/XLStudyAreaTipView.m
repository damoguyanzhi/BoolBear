//
//  XLStudyAreaTipView.m
//  XueLeJW
//
//  Created by RuqiangLiu on 2020/1/16.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import "XLStudyAreaTipView.h"
#import "UIImage+XL.h"

#define XLStudyAreaArrowWidth  8
#define XLStudyAreaArrowHeight 6

@interface XLStudyAreaTipView()

@property(nonatomic,assign)CGFloat arrowRectRight;

@property(nonatomic,copy)NSString *text;

@end

@implementation XLStudyAreaTipView

-(instancetype)initWithFrame:(CGRect)frame text:(NSString *)text arrowRectRight:(CGFloat)arrowRectRight{
    self.arrowRectRight = arrowRectRight;
    self.text = text;
    if(self = [super initWithFrame:frame]){
        [self createArrow];
        [self createUILabel];
        
        CALayer *layer = self.layer;
        layer.shadowColor = @"#103479".toColor.CGColor;
        layer.shadowOpacity = 0.1;
        layer.shadowOffset = CGSizeMake(0, 4);
    }
    return self;
}

-(void)createArrow{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(XLStudyAreaArrowWidth/2,0)];
    [path addLineToPoint:CGPointMake(0, XLStudyAreaArrowWidth)];
    [path addLineToPoint:CGPointMake(XLStudyAreaArrowWidth, XLStudyAreaArrowHeight)];
    [path closePath];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - self.arrowRectRight - XLStudyAreaArrowWidth/2,0, XLStudyAreaArrowWidth, XLStudyAreaArrowHeight)];
    imageView.image = [UIImage gl_imageWithPath:path.CGPath size:CGSizeMake(XLStudyAreaArrowWidth, XLStudyAreaArrowHeight) color:[UIColor whiteColor].CGColor];
    [self addSubview:imageView];
}

-(void)createUILabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, XLStudyAreaArrowHeight, self.frame.size.width, self.frame.size.height - XLStudyAreaArrowHeight)];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.backgroundColor = @"#ffffff".toColor;
    label.textColor = @"#333333".toColor;
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.text;
    [self addSubview:label];
}

@end
