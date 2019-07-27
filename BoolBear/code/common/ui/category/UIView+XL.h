//
//  UIView+XL.h
//  XueLeTS
//
//  Copyright (c) 2015年 net.xuele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XL)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

/*
 * @hgl
 *
 * 给当前视图加一个边框
 *
 */
-(void)addborderWidth:(CGFloat)width borderColor:(UIColor *)color withRadius:(CGFloat)radius;

/*
 * @hgl
 *
 * 给当前视图加一个阴影
 *
 */
-(void)addShadowSize:(CGSize)size Opacity:(CGFloat)opacity;


/*
 * @hgl
 *
 * 将当前视图从父视图中移除
 * 直接调用 removeFromSuperView 如果
 *
 */
- (void)removeSelfFromSuperview;

//截图
-(UIImage *)screenshot;

@end

