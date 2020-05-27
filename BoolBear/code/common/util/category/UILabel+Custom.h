//
//  UILabel+Custom.h
//  BoolBear
//
//  Created by RuqiangLiu on 2020/1/11.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)

/**
 超出指定高度在保留文本之前添加省略号
 
 @param mainTitle 主文字
 @param lastTitle 需要保留文字
 */
-(void)showEndMessage:(NSString *)mainTitle
            lastTitle:(NSString *)lastTitle;

@end
