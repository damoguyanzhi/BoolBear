//
//  CustomButton.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/4.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
    }
    return self;
}

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
                       fontSize:(NSInteger)fontSize{
    UIImage *image = [UIImage imageNamed:imageUrl];
    CGSize infoSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
    CGRect titleSize = [attributedString boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine context:nil];
    self.titleLabel.textColor = [UIColor blackColor];
    [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if(type == CustomButtonImageLeft){
        titleSize.size.width = titleSize.size.width + 5;
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, titleSize.size.width + gap + image.size.width, self.frame.size.height)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -gap)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, gap, 0, 0)];
    }else if(type == CustomButtonImageRight){
        titleSize.size.width = titleSize.size.width + 5;
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, titleSize.size.width + gap + image.size.width, self.frame.size.height)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.size.width + gap, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -(image.size.width*2 + gap), 0, 0)];
    }else if(type == CustomButtonImageTop){
        CGFloat frameWidth = titleSize.size.width > image.size.width ? titleSize.size.width:image.size.width;
        CGFloat imageOffSetX = titleSize.size.width / 2;
        CGFloat imageOffSetY = image.size.height / 2 + gap / 2;
        CGFloat labelOffSetX = image.size.width / 2;
        CGFloat labelOffSetY = titleSize.size.height / 2 + gap / 2;
        
        CGFloat maxWidth = MAX(image.size.width,titleSize.size.width); // 上下排布宽度肯定变小 获取最大宽度的那个
        CGFloat changeWidth = image.size.width + titleSize.size.width - maxWidth; // 横向缩小的总宽度
        CGFloat maxHeight = MAX(image.size.height,titleSize.size.height); // 获取最大高度那个 （就是水平默认排布的时候的原始高度）
        CGFloat changeHeight = image.size.height + titleSize.size.height + gap - maxHeight; // 总高度减去原始高度就是纵向宽大宗高度

        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height)];
        self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffSetY, imageOffSetX, imageOffSetY, -imageOffSetX);
        self.titleEdgeInsets = UIEdgeInsetsMake(labelOffSetY, -labelOffSetX, -labelOffSetY, labelOffSetX);
        self.contentEdgeInsets = UIEdgeInsetsMake(changeHeight - labelOffSetY, - changeWidth / 2, labelOffSetY, -changeWidth / 2);
    }else{
        CGFloat frameWidth = titleSize.size.width > image.size.width ? titleSize.size.width:image.size.width;
        frameWidth = frameWidth + gap*2;
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(titleSize.size.height + gap,(frameWidth-image.size.width - gap)/2, 0, 0)];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0,-image.size.width/2 -gap, image.size.height + gap, 0)];
    }
}

@end
