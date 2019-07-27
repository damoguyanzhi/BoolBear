//
//  DataModel.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/4/10.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property(nonatomic,strong)NSMutableArray *typeNameArray;

@property(nonatomic,strong)NSMutableArray *uiNameArray;

+(instancetype)defaultConfig;

@end
