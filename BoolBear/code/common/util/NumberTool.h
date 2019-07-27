//
//  NumberTool.h
//  BoolBear
//
//  Created by RuqiangLiu on 2018/5/4.
//  Copyright © 2018年 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NumberTool : NSObject


/**
 除

 @param num1 除数
 @param num2 被除数
 @return 结果
 */
+(CGFloat)dividedWithNum:(NSInteger)num1 num2:(NSInteger)num2;

+(NSString *)notRounding:(CGFloat)number afterPoint:(int)position;

@end
