//
//  MBProgressHUD+XL.m
//
//
//  Copyright (c) 2014年 org.hgl. All rights reserved.
//

#import "MBProgressHUD+XL.h"

@implementation MBProgressHUD (XL)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //视图非window    而且高度是整个屏幕大小
    if (self.superview.frame.size.height == [[UIScreen mainScreen] bounds].size.height && ![self.superview isKindOfClass:[UIWindow class]]) {
        CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64);
        if (CGRectContainsPoint(rect, point)) {
            return NO;
        }
    }
    return YES;
}


#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    UIView *temp = view;
    if (view == nil) view = [self lastWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (temp == nil) {
        [hud addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(customHide)]];
    }
//    hud.labelText = text;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:0.7];
}

- (void)customHide{
    [self hideAnimated:YES];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [self lastWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view{
    if (view == nil) view = [self lastWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.0];
    return hud;
}

+ (MBProgressHUD *)showText:(NSString *)text withTime:(NSTimeInterval)time{
    UIView * view = [self lastWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)error withTime:(NSTimeInterval)time{
    UIView *view = nil;
    if (view == nil) view = [self lastWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = error;
    // 设置图片
    NSString *icon = @"success.png";
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error withTime:(NSTimeInterval)time{
    UIView *view = nil;
    if (view == nil) view = [self lastWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = error;
    hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    // 设置图片
    NSString *icon = @"error.png";
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:time];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [self lastWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


+ (UIWindow *)lastWindow
{
    if (@available(iOS 11.0, *)){
#ifdef __IPHONE_11_0
        return [UIApplication sharedApplication].keyWindow;
#endif
    }
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}


@end

