//
//  MJExtensionClassViewController.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/6/24.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationViewController.h"
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJExtensionClassViewController :  CustomNavigationViewController

@end

@interface Ad : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;
@end


@interface User : NSObject
@property (copy, nonatomic) NSString *name;/* 姓名 */
@property (copy, nonatomic) NSString *icon;/* 头像 */
@property (assign, nonatomic) unsigned int age;/* 年龄 */
@property (copy, nonatomic) NSString *height;/* 身高 */
@property (strong, nonatomic) NSNumber *money;/* 资产 */
@property (assign, nonatomic) Sex sex;/* 性别 */
@property (assign, nonatomic, getter=isGay) BOOL gay;/* 是否是同性恋 */
@end

@interface Book: NSObject
@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) NSDate *publishedTime;
@end


@interface StatusResult : NSObject
/** 数组中存储模型Status类型数据 */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 数组中存储模型Ad类型数据 */
@property (strong, nonatomic) NSArray *ads;
@property (strong, nonatomic) NSNumber *totalNumber;
@end

@interface Status : NSObject
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;/* 其他模型类型 */
@property (strong, nonatomic) Status *retweetedStatus;/* 自我模型类型 */
@end

@interface Bag : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double price;
@end

@interface Student : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *nowName;
@property (copy, nonatomic) NSString *oldName;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) Bag *bag;
@end




NS_ASSUME_NONNULL_END
