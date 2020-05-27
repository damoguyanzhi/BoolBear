//
//  XLCircleColorView.m
//  XueLeTS
//
//  Created by shenjiafei on 2020/3/24.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import "XLCircleColorView.h"

@implementation XLCircleColorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lineWidth = 20;
        _percent = 0;
        _fillColor = @"#e5e5e5";
        _beginColor = @"#FF5858";
        _endColor = @"#FAAD3E";
        _lineGap = kCGLineCapRound;
    }
    return self;
}

-(void)setPercent:(float)percent{
    _percent = percent;
    [self draw];
}

- (void)draw{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    // 1. 还是添加一个圆弧路径
    // 获取当前context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 设置线的宽度
    CGContextSetLineWidth(ctx, self.lineWidth);

    // 设置线条端点为圆角
    CGContextSetLineCap(ctx, self.lineGap);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(ctx, self.fillColor.toColor.CGColor);
//    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGFloat originX = rect.size.width / 2;
    CGFloat originY = rect.size.height / 2;
    // 计算半径
    CGFloat radius = MIN(originX, originY) - self.lineWidth;
    
    CGContextAddArc(ctx, rect.size.width / 2, rect.size.height / 2, radius, 0, M_PI*2, 0);
    CGContextStrokePath(ctx);
    if (self.percent == 0) {
        return;
    }
    
    float endFloat = M_PI*2*self.percent - M_PI_2;
    // 逆时针画一个圆弧
    CGContextAddArc(ctx, rect.size.width / 2, rect.size.height / 2, radius, -M_PI_2, endFloat, 0);

    // 2. 创建一个渐变色
    // 创建RGB色彩空间，创建这个以后，context里面用的颜色都是用RGB表示
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // 渐变色的颜色
    NSArray *colorArr = @[
                          (id)self.endColor.toColor.CGColor,
                          (id)self.beginColor.toColor.CGColor
                          ];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorArr, NULL);
    // 释放色彩空间
    CGColorSpaceRelease(colorSpace);
    colorSpace = NULL;

    // ----------以下为重点----------
    // 3. "反选路径"
    // CGContextReplacePathWithStrokedPath
    // 将context中的路径替换成路径的描边版本，使用参数context去计算路径（即创建新的路径是原来路径的描边）。用恰当的颜色填充得到的路径将产生类似绘制原来路径的效果。你可以像使用一般的路径一样使用它。例如，你可以通过调用CGContextClip去剪裁这个路径的描边
    CGContextReplacePathWithStrokedPath(ctx);
    // 剪裁路径
    CGContextClip(ctx);

    // 4. 用渐变色填充
    CGContextDrawLinearGradient(ctx, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height/2), 0);
    // 释放渐变色
    CGGradientRelease(gradient);
}


@end
