//
//  NSString+Custom.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Custom)

- (UIColor *)toColor;

- (UIColor *((^)(CGFloat)))toFullColor;

// 自动计算文字的宽度
- (CGSize)sizeWIthFont:(CGFloat)fontSize height:(CGFloat)height;

// 自动计算文字的高度
- (CGSize)sizeWIthFont:(CGFloat)fontSize width:(CGFloat)width;

@end
