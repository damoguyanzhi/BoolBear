//
//  XLSysGruidanceFilterView.h
//  XueLeTS
//
//  Created by RuqiangLiu on 2020/6/17.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XLSysGruidanceFilterBlock)(NSInteger sectionIndex,NSInteger rowIndex);

@class XLSysGruidanceFilterItemModel;

@interface XLSysGruidanceFilterModel : NSObject

@property (nonatomic,copy) NSString *sectionId;

@property (nonatomic,copy) NSString *sectionName;

@property (nonatomic,strong) NSMutableArray *itemArray;

@end

@interface XLSysGruidanceFilterItemModel : NSObject

@property (nonatomic,copy) NSString *id;

@property (nonatomic,copy) NSString *name;

@end

@interface XLSysGruidanceFilterView : UIView

+ (instancetype)showInView:(NSMutableArray *)array
               currentView:(UIView *)currentView
                 viewWidth:(CGFloat)viewWidth
                     block:(XLSysGruidanceFilterBlock)resultBlock;


+ (instancetype)showInView:(NSMutableArray *)array
        selectSectionIndex:(NSInteger)selectSectionIndex
               selectIndex:(NSInteger)index
               currentView:(UIView *)currentView
                 viewWidth:(CGFloat)viewWidth
                     block:(XLSysGruidanceFilterBlock)resultBlock;


@end


