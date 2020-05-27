//
//  XLPieChartView.h
//  XueLeTS
//
//  Created by shenjiafei on 2020/3/30.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//高度不要小余 200
@interface XLPieChartView : UIView

/**
 数据数组
 */
@property (strong, nonatomic) NSArray *dataArray;

/**
 绘制方法
 */
- (void)draw;

@end

NS_ASSUME_NONNULL_END
