//
//  UIButton+Custom.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/12.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RSButtonTypeLabel) {
    RSButtonTypeLabelRight =0,
    RSButtonTypeLabelLeft,
    RSButtonTypeLabelBottom,
    RSButtonTypeLabelTop
};

@interface UIButton (Custom)

- (void)setButtonShowType:(RSButtonTypeLabel)type;

@end
