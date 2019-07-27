//
//  MJExtensionClassViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/6/24.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "MJExtensionClassViewController.h"
#import "UserModel.h"
#import <MJExtension.h>

@implementation StatusResult
/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"statuses" : @"Status",
              @"ads" : @"Ad"
              };
}

@end

@implementation Student

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"desc" : @"desciption",
             @"oldName" : @"name.oldName",
             @"nowName" : @"name.newName",
             @"nameChangedTime" : @"name.info[1].nameChangedTime",
             @"bag" : @"other.bag",
             };

}

@end

@implementation User


@end


@implementation Status


@end

@implementation Book
/* 转化过程中对字典的值进行过滤和进一步转化 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) {
            return @"";
        }
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    return oldValue;
}
@end

@interface MJExtensionClassViewController ()

@end

@implementation MJExtensionClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self translateDictToModel];
    [self translateJsonToModel];
    [self translateDictArrayToModel];
    [self translateReplaceDictToModel];
    [self translateDictArrayToModelArray];
    [self translateModelArrayToDictArray];
    [self translateDictToCoreModel];
    [self translateDictToFilterModel];
}

-(void)translateDictToModel{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @"1.55",
                           @"money" : @100.9,
                           @"sex" : @(SexFemale),/* 枚举需要使用NSNumber包装 */
                           @"gay" : @"NO"
                           };
    //字典转模型，使用的是mj_objectWithKeyValues:方法
    UserModel *user = [UserModel mj_objectWithKeyValues:dict];
    NSLog(@"字典转模型:%@",user);
}

-(void)translateJsonToModel{
    // 定义一个JSON字符串
    NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    // JSON字符串转模型
    UserModel *user = [UserModel mj_objectWithKeyValues:jsonString];
    NSLog(@"json转模型:%@",user);
}

-(void)translateDictArrayToModel{
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"Nice weather!",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   @{
                                       @"text" : @"Go camping tomorrow!",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   ],
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.ad02.com"
                                       }
                                   ],
                           @"totalNumber" : @"2014"
                           };
    //字典转模型，支持模型的数组属性里面又装着模型
    StatusResult *result = [StatusResult mj_objectWithKeyValues:dict];
    for (Ad *ad in result.ads) {
        //NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }

}

-(void)translateReplaceDictToModel{
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"kids",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{
                                               @"nameChangedTime" : @"2013-08"
                                               }
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"a red bag",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    //字典转模型，支持多级映射
    Student *stu = [Student mj_objectWithKeyValues:dict];
    //打印
    NSLog(@"ID=%@, desc=%@, oldName=%@, nowName=%@, nameChangedTime=%@",
          stu.ID, stu.desc, stu.oldName, stu.nowName, stu.nameChangedTime);
    NSLog(@"bagName=%@", stu.bag);
}

-(void)translateDictArrayToModelArray{
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png"
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png"
                               }
                           ];
    //字典数组转模型数组，使用的是mj_objectArrayWithKeyValuesArray:方法
    NSArray *userArray = [UserModel mj_objectArrayWithKeyValuesArray:dictArray];
    //打印
    for (User *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);
    }
}

-(void)translateModelToDict{
    User *user = [[User alloc] init];
    user.name = @"Jack";
    user.icon = @"lufy.png";
    Status *status = [[Status alloc] init];
    status.user = user;
    status.text = @"Nice mood!";
    //模型转字典，使用的是mj_keyValues属性
    NSDictionary *statusDict = status.mj_keyValues;
    NSLog(@"%@", statusDict);
}

-(void)translateModelArrayToDictArray{
    User *user1 = [[User alloc] init];
    user1.name = @"Jack";
    user1.icon = @"lufy.png";
    User *user2 = [[User alloc] init];
    user2.name = @"Rose";
    user2.icon = @"nami.png";
    NSArray *userArray = @[user1, user2];
    //模型数组转字典数组，使用的是mj_keyValuesArrayWithObjectArray:方法
    NSArray *dictArray = [User mj_keyValuesArrayWithObjectArray:userArray];
    NSLog(@"%@", dictArray);
}

-(void)translateDictToCoreModel{
    NSDictionary *dict = @{
                           @"name" : @"Jack",
                           @"icon" : @"lufy.png",
                           @"age" : @20,
                           @"height" : @1.55,
                           @"money" : @"100.9",
                           @"sex" : @(SexFemale),
                           @"gay" : @"true"
                           };
    //字典转为CoreData模型
    NSManagedObjectContext *context = nil;
    User *user = [User mj_objectWithKeyValues:dict
                                      context:context];
    NSLog(@"%@",user.name);

}

-(void)translateDictToFilterModel{
    NSDictionary *dict = @{
                           @"name" : @"5分钟突破iOS开发",
                           @"publishedTime" : @"2011-09-10"
                           };
    Book *book = [Book mj_objectWithKeyValues:dict];
    NSLog(@"name=%@, publishedTime=%@", book.name, book.publishedTime);
}


@end
