//
//  DataModel.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+(instancetype)defaultConfig{
    static id config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[DataModel alloc]init];
    });
    return config;
}

-(instancetype)init{
    if(self = [super init]){
        _typeNameArray = [[NSMutableArray alloc]initWithObjects:@"UI",@"Tool",@"第三方类demo", nil];
        _uiNameArray = [[NSMutableArray alloc]initWithObjects:@"UIButton",@"UIlabel", nil];
    }
    return self;
}

@end
