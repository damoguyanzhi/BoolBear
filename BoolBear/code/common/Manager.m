//
//  Manager.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/25.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "Manager.h"

@implementation Manager

+(instancetype)sharedManager{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

-(NSInteger)age{
    return 10;
}

@end
