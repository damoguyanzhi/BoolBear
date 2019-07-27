//
//  NSString+Custom.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "NSString+Custom.h"

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

@end
