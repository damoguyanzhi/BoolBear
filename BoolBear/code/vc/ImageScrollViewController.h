//
//  ImageScrollViewController.h
//  BoolBear
//
//  Created by RuqiangLiu on 2020/6/10.
//  Copyright © 2020 RuqiangLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//图片滑动
@interface ImageScrollViewController : UIViewController

- (void)loadImageData;
- (void)addScrollView;
- (void)addImageViewsToScrollView;
- (void)addPageControl;
- (void)addLabel;
- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex;
- (void)setDefaultInfo;
- (void)reloadImage;
- (void)layoutUI;

@end

NS_ASSUME_NONNULL_END
