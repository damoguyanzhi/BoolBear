//
//  CommonData.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/9.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CommonTabBarHeight 49;

@interface CommonData : NSObject

@property(nonatomic,assign)NSInteger navigationBarWidth;

@property(nonatomic,assign)NSInteger navigationBarHeight;

+(instancetype)defaultConfig;

@end
