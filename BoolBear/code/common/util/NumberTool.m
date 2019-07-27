//
//  NumberTool.m
//  BoolBear
//
//  Created by RuqiangLiu on 2018/5/4.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import "NumberTool.h"

@implementation NumberTool


/**
 除

 @param num1 除数
 @param num2 被除数
 @return 结果
 */
+(CGFloat)dividedWithNum:(NSInteger)num1 num2:(NSInteger)num2{
    return (double)num1/(double)num2;
}

+(NSString *)notRounding:(CGFloat)number afterPoint:(int)position{
    
    NSString *message = [NSString stringWithFormat:@"%f",number];
    NSArray *array = [message componentsSeparatedByString:@"."];
    NSString *backMessage = array[1];
    NSInteger currentPosition = position;
    if(backMessage.length < position){
        currentPosition = backMessage.length;
    }
    NSString *formatString = [NSString stringWithFormat:@"%%0.%df",(int)currentPosition];
    NSString *curFloat = [NSString stringWithFormat:formatString,number];
    return curFloat;
    
}

/**
 获取指定位数的小数

 @param number 小数
 @param position 保留位数
 @return 小数
 */
-(NSDecimalNumber *)roundUp:(float)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return roundedOunces;
}

@end
