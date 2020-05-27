//
//  XLCircleColorView.h
//  XueLeTS
//
//  Created by shenjiafei on 2020/3/24.
//  Copyright © 2020 net.xuele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLCircleColorView : UIView

@property (nonatomic, assign) float lineWidth;
@property (nonatomic, assign) float percent;
@property (nonatomic, copy) NSString *beginColor;
@property (nonatomic, copy) NSString *endColor;
@property (nonatomic, copy) NSString *fillColor;
@property (nonatomic, assign) CGLineCap lineGap;

//修改完参数调用立即生效
- (void)draw;

@end

