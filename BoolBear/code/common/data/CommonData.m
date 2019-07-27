//
//  CommonData.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/9.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "CommonData.h"

@implementation CommonData

+(instancetype)defaultConfig{
    static id config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[CommonData alloc]init];
    });
    return config;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _navigationBarWidth = [UIScreen mainScreen].bounds.size.width;
        _navigationBarHeight = 60 ;
    }
    return self;
}

@end
