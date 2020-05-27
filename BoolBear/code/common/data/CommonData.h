//
//  CommonData.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/9.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width;//屏幕宽度
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height;//屏幕宽度

#define CommonTabBarHeight 49;

#define NavigationBarH  [CommonData defaultConfig].navigationBarHeight;

#define WS(weakSelf,var) __weak __typeof(var) weakSelf = var;

//手机操作系统
#define iOS7Later XLIOS(>= , 7.0)
#define iOS8Later XLIOS(>= , 8.0)
#define iOS7 (iOS7Later & !iOS8Later)
#define XLIOS(sign ,index) ([UIDevice currentDevice].systemVersion.doubleValue sign index)

#define iOSVersion [UIDevice currentDevice].systemVersion.floatValue

#ifdef DEBUG
#define BoolLog(...) NSLog(__VA_ARGS__)
#else
#define BoolLog(...)
#endif


@interface CommonData : NSObject

@property(nonatomic,assign)CGFloat navigationBarWidth;

@property(nonatomic,assign)CGFloat navigationBarHeight;

+(instancetype)defaultConfig;

@end
