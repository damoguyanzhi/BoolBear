//
//  MBProgressHUD+XL.h
//
//
//  Copyright (c) 2014年 org.hgl. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (XL)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (MBProgressHUD *)showText:(NSString *)text toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (void)showError:(NSString *)error withTime:(NSTimeInterval)time;
+ (void)showSuccess:(NSString *)error withTime:(NSTimeInterval)time;
+ (MBProgressHUD *)showText:(NSString *)text withTime:(NSTimeInterval)time;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
+ (UIWindow *)lastWindow;
@end
