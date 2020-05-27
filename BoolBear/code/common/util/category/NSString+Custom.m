//
//  NSString+Custom.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "NSString+Custom.h"
#import "CommonData.h"

@implementation NSString (Custom)

- (UIColor *)toColor{
    if (self == nil) {
        return nil;
    }
    unsigned int hexInt = 0;
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:self];
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    // Scan hex value
    [scanner scanHexInt:&hexInt];
    
    // Create color object, specifying alpha as well
    UIColor *color = [UIColor colorWithRed:((CGFloat) ((hexInt & 0xFF0000) >> 16))/255
                                     green:((CGFloat) ((hexInt & 0xFF00) >> 8))/255
                                      blue:((CGFloat) (hexInt & 0xFF))/255
                                     alpha:1];
    
    return color;
}

- (UIColor *((^)(CGFloat)))toFullColor{
    return ^(CGFloat alpha){
        return [[self toColor] colorWithAlphaComponent:alpha];
    };
}

// 自动计算文字的宽度
- (CGSize)sizeWIthFont:(CGFloat)fontSize height:(CGFloat)height
{
    CGSize actualsize = CGSizeZero;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    if (iOS7Later) {
        //get current font attributes
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        //IOS7 fix: get size that text needs, limit the width
        actualsize =[self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:tdic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        actualsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,height) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    return actualsize;
}

// 自动计算文字的高度
- (CGSize)sizeWIthFont:(CGFloat)fontSize width:(CGFloat)width
{
    CGSize actualsize = CGSizeZero;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    if (iOS7Later) {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        actualsize =[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)  attributes:tdic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        actualsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    return actualsize;
}


@end
