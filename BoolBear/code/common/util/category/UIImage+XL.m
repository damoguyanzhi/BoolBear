//
//  UIImage+XL.m
//  XueLeTS
//
//  Created by huang long on 15/12/8.
//  Copyright © 2015年 net.xuele. All rights reserved.
//

#import "UIImage+XL.h"
#import "NSString+Custom.h"
#import <objc/runtime.h>

static const void *CompleteBlockKey = &CompleteBlockKey;
static const void *FailBlockKey = &FailBlockKey;

@interface UIImage ()

@property (nonatomic,copy)  void(^CompleteBlock)(void);

@property (nonatomic,copy)  void(^FailBlock)(void);

@end

@implementation UIImage (XL)

/*
 *  模拟成员变量
 */
-(void (^)(void))FailBlock{
    return objc_getAssociatedObject(self, FailBlockKey);
}
-(void)setFailBlock:(void (^)(void))FailBlock{
    objc_setAssociatedObject(self, FailBlockKey, FailBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)(void))CompleteBlock{
    return objc_getAssociatedObject(self, CompleteBlockKey);
}

-(void)setCompleteBlock:(void (^)(void))CompleteBlock{
    objc_setAssociatedObject(self, CompleteBlockKey, CompleteBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIImage *)scaleImageWithMaxLength:(CGFloat)length{
    CGSize size = self.size;
    if (size.width > size.height) { //e.g   1200 x 200  -->  300 x 50
        size = CGSizeMake(length, size.height * length / size.width);
    }else if(size.width == size.height){ //e.g   1200 x 1200  -->  300 x 300
        size = CGSizeMake(length, length);
    }else{  //e.g   200 x 1200  -->  50 x 300
        size = CGSizeMake( size.width * length / size.height,length);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (UIImage *)scaleImageWithMinLength:(CGFloat)length{
    CGSize size = self.size;
    if (size.width < size.height) { //e.g   1200 x 3000  -->  300 x 750
        size = CGSizeMake(length, size.height * length / size.width);
    }else if(size.width == size.height){ //e.g   1200 x 1200  -->  300 x 300
        size = CGSizeMake(length, length);
    }else{  //e.g   3000 x 1200  -->  750 x 300
        size = CGSizeMake( size.width * length / size.height,length);
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

/**
 *  保存相册
 *
 *  @param completeBlock 成功回调
 *  @param failBlock 出错回调
 */
-(void)savedPhotosAlbum:(void(^)(void))completeBlock failBlock:(void(^)(void))failBlock{
    
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
    
    self.CompleteBlock = completeBlock;
    self.FailBlock = failBlock;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error == nil){
        if(self.CompleteBlock != nil) self.CompleteBlock();
    }else{
        if(self.FailBlock !=nil) self.FailBlock();
    }
    
}

+(UIImage *)badgeImageWithColor:(UIColor *)color withSize:(CGSize)size{
    //    //新建一个图片图形上下文
    CGFloat radius = size.width >= size.height ? (size.width  * 0.5) : (size.height * 0.5);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContext(size);
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextAddArc(ctx, size.width * 0.5, size.height * 0.5, radius, 0, 2*M_PI, 0);
    CGContextDrawPath(ctx,kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *)getPurityImageWithColor:(UIColor *)color{
    return [self getPurityImageWithColor:color withSize:CGSizeMake(1, 1)];
}

+(UIImage *)getPurityImageWithColor:(UIColor *)color withSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)blankImageWithIndex:(NSInteger)index{
    if (index <= 0) {
        index = 0;
    }
    NSString *indexStr = @(index).stringValue;
    static NSMutableDictionary * dict;
//    NSMutableDictionary *dict = [XLCommonVariable sharedXLCommonVariable].blankDict;
    if (dict == nil) {
        dict = [NSMutableDictionary dictionary];
    }
    UIImage *img = [dict objectForKey:indexStr];
    if (img) {
        return img;
    }else{
        UIImage *img=[UIImage imageNamed:@"work_newque_fill"];
        UIImage *image = [UIImage blankImage:img WithIndex:index];
        if (!image) {
            image = img;
        }
        [dict setObject:image forKey:indexStr];
        return image;
    }
}

+ (UIImage *)blankImage:(UIImage *)image WithIndex:(NSInteger)index{
   //绘制填空题空格
    NSString *indexStr = @(index).stringValue;
    UIFont *font = [UIFont systemFontOfSize:10];
    NSDictionary* dic = @{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blueColor]};
//    UIGraphicsBeginImageContext(CGSizeMake(image.size.width + 4, image.size.height));
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width + 8, image.size.height), 0, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(4, 0, image.size.width, image.size.height)];
    CGSize indexSize = [indexStr sizeWithAttributes:dic];
    CGRect re={CGPointMake((image.size.width-indexSize.width) * 0.5 + 4,(image.size.height-indexSize.height) * 0.5 - 3),indexSize};
    [indexStr drawInRect:re withAttributes:dic];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    return newImage;
}

+ (UIImage *)navigationImage{
    return [self getPurityImageWithColor:@"#ff5722".toColor];
}

+ (UIImage *)personImage{
    return [UIImage imageNamed:@"menu_role_header_default"];
}

UIImage * UIImageWithName(NSString *imageName){
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)circleImage:(UIColor *)color size:(CGSize)size{
    //    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContext(size);
    
    CGFloat centerX = size.width * 0.5;
    CGFloat centerY = size.height * 0.5;
    CGFloat radius = centerX > centerY ? centerY : centerX;
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextAddArc(ctx, centerX, centerY, radius, 0, 2*M_PI, 0);
    //    CGContextFillRect(ctx, CGRectMake(0, 0, 16, 16));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)gl_imageWithPath:(CGPathRef)pathRef size:(CGSize)size color:(CGColorRef)colorRef{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, colorRef);
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context, kCGPathEOFill);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)gl_imageWithSize:(CGSize)size radius:(CGFloat)radius color:(UIColor *)color{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    return [self gl_imageWithPath:path.CGPath size:size color:color.CGColor];
}

+ (UIImage *)lineImage:(CGFloat)colWidth width:(CGSize)size color:(UIColor *)color{
    //    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContext(size);
    
    CGFloat margin = (size.width - colWidth)* 0.5;
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextAddRect(ctx, CGRectMake(margin, 0, colWidth, size.height));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)lineImage:(CGFloat)colWidth width:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius{
    //    //新建一个图片图形上下文
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContext(size);
    
    CGFloat margin = (size.width - colWidth)* 0.5;
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(margin, 0, colWidth, size.height) cornerRadius:radius];
    CGContextAddPath(ctx, path.CGPath);
    //    CGContextAddRect(ctx, CGRectMake(margin, 0, colWidth, size.height));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
