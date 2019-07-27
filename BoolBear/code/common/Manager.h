//
//  Manager.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/25.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Manager : NSObject

@property(nonatomic,assign)NSInteger age;

+(instancetype)sharedManager;

@end


