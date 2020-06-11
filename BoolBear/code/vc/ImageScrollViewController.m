//
//  ImageScrollViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on //.
//  Copyright ©  RuqiangLiu. All rights reserved.
//

#import "ImageScrollViewController.h"

#define kWidthOfScreen [[UIScreen mainScreen] bounds].size.width
#define kHeightOfScreen [[UIScreen mainScreen] bounds].size.height
#define kImageViewCount

@interface ImageScrollViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrV;
@property (strong, nonatomic) UIPageControl *pageC;
@property (strong, nonatomic) UIImageView *imgVLeft;
@property (strong, nonatomic) UIImageView *imgVCenter;
@property (strong, nonatomic) UIImageView *imgVRight;
@property (strong, nonatomic) UILabel *lblImageDesc;
@property (strong, nonatomic) NSMutableDictionary *mDicImageData;
@property (assign, nonatomic) NSUInteger currentImageIndex;
@property (assign, nonatomic) NSUInteger imageCount;

@end

@implementation ImageScrollViewController

- (void)viewDidLoad {
     [super viewDidLoad];

    [self layoutUI];
}

 - (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 - (void)loadImageData {
     NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageInfo" ofType:@"plist"];
    _mDicImageData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    _imageCount = _mDicImageData.count;
}

 - (void)addScrollView {
    _scrV = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _scrV.contentSize = CGSizeMake(kWidthOfScreen * 3, kHeightOfScreen);
    _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0);
    _scrV.pagingEnabled = YES;
    _scrV.showsHorizontalScrollIndicator = NO;
     _scrV.delegate = self;
     [self.view addSubview:_scrV];
 }

 - (void)addImageViewsToScrollView {
     //图片视图；左边
       _imgVLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, kWidthOfScreen, kHeightOfScreen)];
      _imgVLeft.contentMode = UIViewContentModeScaleAspectFit;
      [_scrV addSubview:_imgVLeft];
 
      //图片视图；中间
      _imgVCenter = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen, 0.0, kWidthOfScreen, kHeightOfScreen)];
      _imgVCenter.contentMode = UIViewContentModeScaleAspectFit;
      [_scrV addSubview:_imgVCenter];
 
      //图片视图；右边
     _imgVRight = [[UIImageView alloc] initWithFrame:CGRectMake(kWidthOfScreen * 2.0, 0.0, kWidthOfScreen, kHeightOfScreen)];
      _imgVRight.contentMode = UIViewContentModeScaleAspectFit;
      [_scrV addSubview:_imgVRight];
  }
 
  - (void)addPageControl {
      _pageC = [UIPageControl new];
     CGSize size= [_pageC sizeForNumberOfPages:_imageCount]; //根据页数返回 UIPageControl 合适的大小
     _pageC.bounds = CGRectMake(0.0, 0.0, size.width, size.height);
     _pageC.center = CGPointMake(kWidthOfScreen / 2.0, kHeightOfScreen - 80.0);
     _pageC.numberOfPages = _imageCount;
     _pageC.pageIndicatorTintColor = [UIColor whiteColor];
     _pageC.currentPageIndicatorTintColor = [UIColor brownColor];
     _pageC.userInteractionEnabled = NO; //设置是否允许用户交互；默认值为 YES，当为 YES 时，针对点击控件区域左（当前页索引减一，最小为）右（当前页索引加一，最大为总数减一），可以编写 UIControlEventValueChanged 的事件处理方法
     [self.view addSubview:_pageC];
 }

 - (void)addLabel {
     _lblImageDesc = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 40.0, kWidthOfScreen, 40.0)];
     _lblImageDesc.textAlignment = NSTextAlignmentCenter;
     _lblImageDesc.textColor = [UIColor whiteColor];
     _lblImageDesc.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
     _lblImageDesc.text = @"Fucking now.";
     [self.view addSubview:_lblImageDesc];
 }

 - (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
     NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)currentImageIndex];
     _imgVCenter.image = [UIImage imageNamed:currentImageNamed];
     _imgVLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.png", (unsigned long)((_currentImageIndex -  + _imageCount) % _imageCount)]];
     _imgVLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.png", (unsigned long)((_currentImageIndex + 1) % _imageCount)]];
     _pageC.currentPage = currentImageIndex;
     _lblImageDesc.text = _mDicImageData[currentImageNamed];
 }

 - (void)setDefaultInfo {
    _currentImageIndex = 0;
     [self setInfoByCurrentImageIndex:_currentImageIndex];
 }

 - (void)reloadImage {
     CGPoint contentOffset = [_scrV contentOffset];
     if (contentOffset.x > kWidthOfScreen) { //向左滑动
         _currentImageIndex = (_currentImageIndex + 1) % _imageCount;
     } else if (contentOffset.x < kWidthOfScreen) { //向右滑动
         _currentImageIndex = (_currentImageIndex -  + _imageCount) % _imageCount;
     }

     [self setInfoByCurrentImageIndex:_currentImageIndex];
 }

 - (void)layoutUI {
     self.view.backgroundColor = [UIColor blackColor];

     [self loadImageData];
     [self addScrollView];
     [self addImageViewsToScrollView];
     [self addPageControl];
     [self addLabel];
     [self setDefaultInfo];
 }

 #pragma mark - UIScrollViewDelegate
 - (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     [self reloadImage];

     _scrV.contentOffset = CGPointMake(kWidthOfScreen, 0.0);
     _pageC.currentPage = _currentImageIndex;

     NSString *currentImageNamed = [NSString stringWithFormat:@"%lu.png", (unsigned long)_currentImageIndex];
     _lblImageDesc.text = _mDicImageData[currentImageNamed];
}
@end
