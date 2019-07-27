//
//  ShowModel.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/25.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "ShowModel.h"

@implementation ShowModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"typeList":[ShowTypeModel class]};
}

@end

@implementation ShowTypeModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"sonContent":[ShowSonModel class]};
}

@end

@implementation ShowSonModel


@end
