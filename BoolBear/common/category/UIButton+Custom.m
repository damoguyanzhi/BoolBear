//
//  UIButton+Custom.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/12.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "UIButton+Custom.h"

@implementation UIButton (Custom)

- (void)setButtonShowType:(RSButtonTypeLabel)type
{
    [self layoutIfNeeded];
    CGRect titleFrame = self.titleLabel.frame;
    CGRect imageFrame = self.imageView.frame;
    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width + 4;
    switch (type) {
        case RSButtonTypeLabelRight: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, imageFrame.size.width - space, 0, -(imageFrame.size.width - space))];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, imageFrame.origin.x - titleFrame.origin.x)];
        }
            break;
        case RSButtonTypeLabelLeft: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleFrame.size.width + space, 0, -(titleFrame.size.width + space))];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(titleFrame.origin.x - imageFrame.origin.x), 0, titleFrame.origin.x - imageFrame.origin.x)];
        }
            break;
        case RSButtonTypeLabelBottom: {
            [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleFrame.size.height + space, -(titleFrame.size.width))];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(imageFrame.size.height + space, -(imageFrame.size.width), 0, 0)];
        }
            break;
        case RSButtonTypeLabelTop: {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageFrame.size.width), imageFrame.size.height + space, 0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(titleFrame.size.height + space, 0, 0, -titleFrame.size.width)];
        }
            break;
        default:
            break;
    }
}

@end
