//
//  CustomNaviationBarView.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/9.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "CustomNaviationBarView.h"
#import "NSString+Custom.h"

@interface CustomNaviationBarView()

@end

@implementation CustomNaviationBarView

#pragma mark - lifecycle (生命周期)

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self makeUI];
    }
    return self;
}


#pragma mark - delegate (每一种代理 mark一次)

#pragma mark - event (事件)

#pragma mark - network
#pragma mark - override (重写父类的方法)
#pragma mark - public method
#pragma mark - private method

-(void)makeUI{
    self.backgroundColor = @"#00b6f2".toColor;
    [self setFrame:CGRectMake(0, 0, [CommonData defaultConfig].navigationBarWidth, [CommonData defaultConfig].navigationBarHeight)];
    [self leftButton];
}

#pragma mark - setter getter

-(UIButton *)leftButton{
    if(!_leftButton){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
        [button setImage:[UIImage imageNamed:@"cloudTeach_button_close"] forState:UIControlStateNormal];
        [self addSubview:button];
        _leftButton = button;
    }
    return _leftButton;
}

@end
