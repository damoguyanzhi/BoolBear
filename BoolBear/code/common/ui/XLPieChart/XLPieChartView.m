//
//  XLPieChartView.m
//  XueLeTS
//
//  Created by shenjiafei on 2020/3/30.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import "XLPieChartView.h"
#import "XLPieChartModel.h"

#define CHART_MARGIN 60
#define TEXT_WIDTH 60.0f //字体宽度

@interface XLPieChartView ()

@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *colorArray;

@end

@implementation XLPieChartView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}



- (void)draw {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect{
    
    CGPoint center =  CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    CGFloat radius = 70;
    CGFloat start = -M_PI_2;
    CGFloat angle = 0;
    CGFloat end = start;
    
    if (self.dataArray.count == 0) {
        
        end = start + M_PI * 2;
        
        UIColor *color = @"#999999".toColor;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
        
        [color set];
        
        //添加一根线到圆心
        [path addLineToPoint:center];
        [path fill];
        
    } else {
        
        NSMutableArray *pointArray = [NSMutableArray array];
        NSMutableArray *centerArray = [NSMutableArray array];
        
        self.modelArray = [NSMutableArray array];
        self.colorArray = [NSMutableArray array];
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            XLPieChartModel *model = self.dataArray[i];
            CGFloat percent = model.rate;
            UIColor *color = model.color;
            
            start = end;
            
            angle = percent * M_PI * 2;
            
            end = start + angle;
            
            UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:start endAngle:end clockwise:true];
            
            [color set];
            
            //添加一根线到圆心
            [path addLineToPoint:center];
            [path fill];
            
            
            // 获取弧度的中心角度
            CGFloat radianCenter = (start + end) * 0.5;
            
            
            // 获取指引线的起点
            CGFloat lineStartX = self.frame.size.width * 0.5 + radius * cos(radianCenter);
            CGFloat lineStartY = self.frame.size.height * 0.5 + radius * sin(radianCenter);
            
            
            CGPoint point = CGPointMake(lineStartX, lineStartY);
            
            if (i <= self.dataArray.count / 2 - 1) {
                [pointArray insertObject:[NSValue valueWithCGPoint:point] atIndex:0];
                [centerArray insertObject:[NSNumber numberWithFloat:radianCenter] atIndex:0];
                [self.modelArray insertObject:model atIndex:0];
                [self.colorArray insertObject:color atIndex:0];
            } else {
                [pointArray addObject:[NSValue valueWithCGPoint:point]];
                [centerArray addObject:[NSNumber numberWithFloat:radianCenter]];
                [self.modelArray addObject:model];
                [self.colorArray addObject:color];
            }
        }
        
        // 通过pointArray绘制指引线
        [self drawLineWithPointArray:pointArray centerArray:centerArray];
        
    }
    
    // 在中心添加centerView
    UIView *centerView = [[UIView alloc] init];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.frame = CGRectMake(0, 0, radius*2-40, radius*2-40);
    centerView.layer.cornerRadius = (radius*2-40) *0.5;
    centerView.layer.masksToBounds = true;
    
    CGRect frame = centerView.frame;
    frame.origin = CGPointMake(self.frame.size.width * 0.5 - frame.size.width * 0.5, self.frame.size.height * 0.5 - frame.size.width * 0.5);
    centerView.frame = frame;
    
    [self addSubview:centerView];
}


- (void)drawLineWithPointArray:(NSArray *)pointArray centerArray:(NSArray *)centerArray {
    
    // 记录每一个指引线包括数据所占用位置的和（总体位置）
    CGRect rect = CGRectZero;
    
    // 用于计算指引线长度
    CGFloat width = self.bounds.size.width * 0.5;
    
    for (int i = 0; i < pointArray.count; i++) {
        
        // 取出数据
        NSValue *value = pointArray[i];
        
        // 每个圆弧中心店的位置
        CGPoint point = value.CGPointValue;
        
        // 每个圆弧中心点的角度
        CGFloat radianCenter = [centerArray[i] floatValue];
        
        // 颜色（绘制数据时要用）
//        UIColor *color = self.colorArray[i % 6];
        UIColor *color = [UIColor grayColor];
        
        // 模型数据（绘制数据时要用）
        XLPieChartModel *model = self.modelArray[i];
        
        // 模型的数据
        NSString *name = model.name;
        NSString *number = [NSString stringWithFormat:@"(%.2f%%)", model.rate * 100];
        
        
        // 圆弧中心点的x值和y值
        CGFloat x = point.x;
        CGFloat y = point.y;
        
        // 指引线终点的位置（x, y）
        CGFloat startX = x;//+ 10 * cos(radianCenter)
        CGFloat startY = y;//+ 10 * sin(radianCenter)
        
        // 指引线转折点的位置(x, y)
        CGFloat breakPointX = x + 20 * cos(radianCenter);
        CGFloat breakPointY = y + 20 * sin(radianCenter);
        
        if (x <= width) { // 在左边
            breakPointY = breakPointY - 10;
        }else{
            breakPointY = breakPointY + 30;
        }
        
        // 转折点到中心竖线的垂直长度（为什么+20, 在实际做出的效果中，有的转折线很丑，+20为了美化）
        CGFloat margin = fabs(width - breakPointX) + 20;
        
        // 指引线长度
        CGFloat lineWidth = width - margin;
        
        // 指引线起点（x, y）
        CGFloat endX;
        CGFloat endY;
        
        // 绘制文字和数字时，所占的size（width和height）
        // width使用lineWidth更好，我这么写固定值是为了达到产品要求
        CGFloat numberWidth = TEXT_WIDTH;
        CGFloat numberHeight = 12.f;
        
        CGFloat titleWidth = numberWidth;
        CGFloat titleHeight = numberHeight;
        
        // 绘制文字和数字时的起始位置（x, y）与上面的合并起来就是frame
        CGFloat numberX;// = breakPointX;
        CGFloat numberY = breakPointY - numberHeight;
        
        CGFloat titleX = breakPointX;
        CGFloat titleY = breakPointY + 2;
        
        
        // 文本段落属性(绘制文字和数字时需要)
        NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
        
        paragraph.alignment = NSTextAlignmentLeft;
        
        // 判断x位置，确定在指引线向左还是向右绘制
        // 根据需要变更指引线的起始位置
        // 变更文字和数字的位置
        if (x <= width) { // 在左边
            
            endX = 20+TEXT_WIDTH;
            endY = breakPointY;
            
            numberX = endX;
            titleX = endX;
            
        } else {    // 在右边
            
            endX = self.bounds.size.width - 20-TEXT_WIDTH;
            endY = breakPointY;
            
            numberX = endX - numberWidth;
            titleX = endX - titleWidth;
        }
        
        
        if (i != 0) {
            
            // 当i!=0时，就需要计算位置总和(方法开始出的rect)与rect1(将进行绘制的位置)是否有重叠
            CGRect rect1 = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
            
            CGFloat margin = 0;
            
            if (CGRectIntersectsRect(rect, rect1)) {
                // 两个面积重叠
                // 三种情况
                // 1. 压上面
                // 2. 压下面
                // 3. 包含
                // 通过计算让面积重叠的情况消除
                if (CGRectContainsRect(rect, rect1)) {// 包含
                    
                    if (i % self.dataArray.count <= self.dataArray.count * 0.5 - 1) {
                        // 将要绘制的位置在总位置偏上
                        margin = CGRectGetMaxY(rect1) - rect.origin.y;
                        endY -= margin;
                    } else {
                        // 将要绘制的位置在总位置偏下
                        margin = CGRectGetMaxY(rect) - rect1.origin.y;
                        endY += margin;
                    }
                    
                    
                } else {    // 相交
                    
                    if (CGRectGetMaxY(rect1) > rect.origin.y && rect1.origin.y < rect.origin.y) { // 压在总位置上面
                        margin = CGRectGetMaxY(rect1) - rect.origin.y;
                        endY -= margin;
                        
                    } else if (rect1.origin.y < CGRectGetMaxY(rect) &&  CGRectGetMaxY(rect1) > CGRectGetMaxY(rect)) {  // 压总位置下面
                        margin = CGRectGetMaxY(rect) - rect1.origin.y;
                        endY += margin;
                    }
                    
                }
                
            }
            
            if (endY > self.height-12) {
                endY  = self.height -12;
            }
            
            titleY = endY + 2;
            numberY = endY - numberHeight;
            
            
            // 通过计算得出的将要绘制的位置
            CGRect rect2 = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
            
            // 把新获得的rect和之前的rect合并
            if (numberX == rect.origin.x) {
                // 当两个位置在同一侧的时候才需要合并
                if (rect2.origin.y < rect.origin.y) {
                    rect = CGRectMake(rect.origin.x, rect2.origin.y, rect.size.width, rect.size.height + rect2.size.height);
                } else {
                    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + rect2.size.height);
                }
            }
            
        } else {
            rect = CGRectMake(numberX, numberY, numberWidth, titleY + titleHeight - numberY);
        }
        
        // 重新制定转折点
        if (endX == 20+TEXT_WIDTH) {
            breakPointX = endX + lineWidth-TEXT_WIDTH;
        } else {
            breakPointX = endX - lineWidth+TEXT_WIDTH;
        }
        
        
        if (endY > self.height-12) {
            endY  = self.height -12;
        }
        
        breakPointY = endY;
        
        //1.获取上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        //2.绘制路径
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(endX, endY)];
        
        [path addLineToPoint:CGPointMake(breakPointX, breakPointY)];
        
        [path addLineToPoint:CGPointMake(startX, startY)];
        
        CGContextSetLineWidth(ctx, 0.5);
        
        //设置颜色
        [color set];
        
        //3.把绘制的内容添加到上下文当中
        CGContextAddPath(ctx, path.CGPath);
        //4.把上下文的内容显示到View上(渲染到View的layer)(stroke fill)
        CGContextStrokePath(ctx);
        
        
        
        // 在终点处添加点(小圆点)
        // movePoint，让转折线指向小圆点中心
        CGFloat movePoint = -1.5;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = color;
        [self addSubview:view];
        CGRect rect = view.frame;
        rect.size = CGSizeMake(3, 3);
        rect.origin = CGPointMake(endX + movePoint, endY - 1.5);
        view.frame = rect;
        view.layer.cornerRadius = 1.5;
        view.layer.masksToBounds = true;
        
        float nameLeftX;
        float titleLeftX;
        if (endX == 20+TEXT_WIDTH) {//左边
            nameLeftX = numberX-TEXT_WIDTH;
            titleLeftX = titleX-TEXT_WIDTH;
        } else {
            nameLeftX = numberX+TEXT_WIDTH+5;
            titleLeftX = titleX+TEXT_WIDTH+5;
        }
        
        //指引线上面的数字
        
        if (numberY > self.height-24) {
            numberY = self.height - 24;
        }
        
        [name drawInRect:CGRectMake(nameLeftX, numberY, numberWidth, numberHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:@"#212121".toColor,NSParagraphStyleAttributeName:paragraph}];
        
        // 指引线下面的title
        if (titleY > self.height-12) {
            titleY = self.height - 12;
        }
        [number drawInRect:CGRectMake(titleLeftX, titleY, titleWidth, titleHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:@"#999999".toColor,NSParagraphStyleAttributeName:paragraph}];
        
    }
}


@end
