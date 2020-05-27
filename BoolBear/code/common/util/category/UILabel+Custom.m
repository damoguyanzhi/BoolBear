//
//  UILabel+Custom.m
//  BoolBear
//
//  Created by RuqiangLiu on 2020/1/11.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

/**
 超出指定高度在保留文本之前添加省略号
 
 @param mainTitle 主文字
 @param lastTitle 需要保留文字
 */
-(void)showEndMessage:(NSString *)mainTitle
               lastTitle:(NSString *)lastTitle{
    NSString *totalTitle = [NSString stringWithFormat:@"%@%@",mainTitle,lastTitle];
    CGSize size = [totalTitle sizeWIthFont:self.font.pointSize width:self.frame.size.width];
    if(size.height > self.height){
        NSString *replaceMessage = @"...";
        for(NSInteger i = mainTitle.length - 1;i>replaceMessage.length;i--){
            NSInteger replaceIndex = i - (replaceMessage.length - 1);
            NSString *newTotalTitle = [totalTitle stringByReplacingCharactersInRange:NSMakeRange(replaceIndex, mainTitle.length - replaceIndex) withString:replaceMessage];
            CGSize newSize = [newTotalTitle sizeWIthFont:self.font.pointSize width:self.width];
            if(newSize.height <= self.height){
                totalTitle = newTotalTitle;
                break;
            }
        }
    }
    self.text = totalTitle;
}


@end
