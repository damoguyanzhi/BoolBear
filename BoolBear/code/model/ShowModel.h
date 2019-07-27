//
//  ShowModel.h
//  BoolBear
//
//  Created by RuqiangLiu on 2019/7/25.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShowTypeModel;
@class ShowSonModel;

//展示细节
@interface ShowModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray<ShowTypeModel *> *typeList;

@end


@interface ShowTypeModel :NSObject

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *vc;
@property(nonatomic,strong)NSArray<ShowSonModel *> *sonContent;

@end

@interface ShowSonModel : NSObject

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *exampleVC;

@end

