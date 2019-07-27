//
//  CustomButton.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/4.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CustomButtonType) {
    CustomButtonImageLeft,
    CustomButtonImageRight,
    CustomButtonImageTop,
    CustomButtonImageBottom,
};

@interface CustomButton : UIButton

/**

 @param type 按钮类型
 @param attributedString 文字
 @param imageUrl 图片地址
 @param gap 文字图片间距
 @param fontSize 文字尺寸
 */
-(void)createButtonType:(CustomButtonType)type
               attributedString:(NSMutableAttributedString *)attributedString
                       imageUrl:(NSString *)imageUrl
                            gap:(NSInteger)gap
                       fontSize:(NSInteger)fontSize;


@end
