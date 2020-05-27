//
//  XLPieChartModel.h
//  XueLeTS
//
//  Created by shenjiafei on 2020/3/30.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLPieChartModel : NSObject

/**
 名称
 */
@property (copy, nonatomic) NSString *name;

/**
 比例
 */
@property (assign, nonatomic) CGFloat rate;


/**
 颜色
 */
@property (strong, nonatomic) UIColor *color;

@end

NS_ASSUME_NONNULL_END
