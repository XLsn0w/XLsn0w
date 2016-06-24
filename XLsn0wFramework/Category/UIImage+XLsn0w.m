
#import "UIImage+XLsn0w.h"

@implementation UIImage (XLsn0w)

+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size color:(UIColor *)color {
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size andColor:(UIColor *)color {
    return [self xlsn0w_createImageWithCGSize:size color:color];
}


+ (UIImage *)xlsn0w_navigtionBarBackButtonImage:(UIColor *)color {
    CGSize size = CGSizeMake(16.0, 30.0);
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [[UIColor clearColor] set];
    UIRectFill(CGRectMake(0, 0, 16.0, 30.0));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    const CGFloat *cs = CGColorGetComponents(color.CGColor);
    //画四个边角
    CGContextSetLineWidth(ctx, 2.5);
    CGContextSetRGBStrokeColor(ctx, cs[0], cs[1], cs[2], CGColorGetAlpha(color.CGColor));
    
    //左上角
    CGPoint pointA[] = {
        CGPointMake(1, 15.5),
        CGPointMake(10, 6)
    };
    
    CGPoint pointB[] = {
        CGPointMake(1, 14.5),
        CGPointMake(10, 24)
    };
    CGContextAddLines(ctx, pointA, 2);
    CGContextAddLines(ctx, pointB, 2);
    CGContextStrokePath(ctx);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

#import <objc/runtime.h>

@implementation UIImage (XLImage)
/**
 定义完毕新方法后,需要弄清楚什么时候实现与系统的方法交互?
 答 : 既然是给系统的方法添加额外的功能,换句话说,我们以后在开发中都是使用自己定义的方法,取代系统的方法,所以,当程序一启动,就要求能使用自己定义的功能方法.说这里:我们必须要弄明白一下两个方法 :
 +(void)initialize(当类第一次被调用的时候就会调用该方法,整个程序运行中只会调用一次)
 + (void)load(当程序启动的时候就会调用该方法,换句话说,只要程序一启动就会调用load方法,整个程序运行中只会调用一次)
 */



+ (void)load {
    /*
     self:UIImage
     谁的事情,谁开头 1.发送消息(对象:objc) 2.注册方法(方法编号:sel) 3.交互方法(方法:method) 4.获取方法(类:class)
     Method:方法名
     
     获取方法,方法保存到类
     Class:获取哪个类方法
     SEL:获取哪个方法
     imageName
     */
    // 获取imageName:方法的地址
    Method imageNameMethod = class_getClassMethod(self, @selector(imageNamed:));
    
    // 获取wg_imageWithName:方法的地址
    Method wg_imageWithNameMethod = class_getClassMethod(self, @selector(wg_imageWithName:));
    
    // 交换方法地址，相当于交换实现方式
    method_exchangeImplementations(imageNameMethod, wg_imageWithNameMethod);
    
}

// 加载图片, 判断是否为空
+ (UIImage *)wg_imageWithName:(NSString *)imageName {
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [UIImage wg_imageWithName:imageName];
    if (!image) {
        NSLog(@"imageNamed对应图片名称不符或者不存在");
    }
    return image;
}

@end

#import <objc/runtime.h>

static const char *image_borderColorKey = "image_borderColorKey";
static const char *image_borderWidthKey = "image_borderWidthKey";
static const char *image_pathColorKey = "image_pathColorKey";
static const char *image_pathWidthKey = "image_pathWidthKey";

@implementation UIImage (ImageCliped)

#pragma mark - Border
- (CGFloat)xl_borderWidth {
    NSNumber *borderWidth = objc_getAssociatedObject(self, s_hyb_image_borderWidthKey);
    
    if ([borderWidth respondsToSelector:@selector(doubleValue)]) {
        return borderWidth.doubleValue;
    }
    
    return 0;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self,
                             image_borderWidthKey,
                             @(xl_borderWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)xl_pathWidth {
    NSNumber *width = objc_getAssociatedObject(self, image_pathWidthKey);
    
    if ([width respondsToSelector:@selector(doubleValue)]) {
        return width.doubleValue;
    }
    
    return 0;
}

- (void)setPathWidth:(CGFloat)pathWidth {
    objc_setAssociatedObject(self,
                             image_pathWidthKey,
                             @(xl_pathWidth),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)pathColor {
    UIColor *color = objc_getAssociatedObject(self, image_pathColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor whiteColor];
}

- (void)setPathColor:(UIColor *)pathColor {
    objc_setAssociatedObject(self,
                             image_pathColorKey,
                             xl_pathColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIColor *)borderColor {
    UIColor *color = objc_getAssociatedObject(self, image_borderColorKey);
    
    if (color) {
        return color;
    }
    
    return [UIColor lightGrayColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self,
                             image_borderColorKey,
                             xl_borderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Clip
- (UIImage *)xl_clipToSize:(CGSize)targetSize {
    return [self hyb_clipToSize:targetSize isEqualScale:YES];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize isEqualScale:(BOOL)isEqualScale {
    return [self hyb_private_clipImageToSize:targetSize
                                cornerRadius:0
                                     corners:UIRectCornerAllCorners
                             backgroundColor:[UIColor whiteColor]
                                isEqualScale:isEqualScale
                                    isCircle:NO];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale {
    return [self hyb_private_clipImageToSize:targetSize
                                cornerRadius:cornerRadius
                                     corners:UIRectCornerAllCorners
                             backgroundColor:backgroundColor
                                isEqualScale:isEqualScale
                                    isCircle:NO];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius {
    return [self hyb_clipToSize:targetSize
                   cornerRadius:cornerRadius
                backgroundColor:[UIColor whiteColor]
                   isEqualScale:YES];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale {
    return [self hyb_private_clipImageToSize:targetSize
                                cornerRadius:cornerRadius
                                     corners:corners
                             backgroundColor:backgroundColor
                                isEqualScale:isEqualScale
                                    isCircle:NO];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners {
    return [self xl_clipToSize:targetSize
                   cornerRadius:cornerRadius
                        corners:corners
                backgroundColor:[UIColor whiteColor]
                   isEqualScale:YES];
}

- (UIImage *)xl_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale {
    return [self xl_private_clipImageToSize:targetSize
                                cornerRadius:0
                                     corners:UIRectCornerAllCorners
                             backgroundColor:backgroundColor
                                isEqualScale:isEqualScale
                                    isCircle:YES];
}

- (UIImage *)xl_clipCircleToSize:(CGSize)targetSize {
    return [self xl_clipCircleToSize:targetSize backgroundColor:[UIColor whiteColor] isEqualScale:YES];
}

- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale
                   isCircle:(BOOL)isCircle {
    return [self xl_private_clipImageToSize:targetSize
                                cornerRadius:cornerRadius
                                     corners:corners
                             backgroundColor:backgroundColor
                                isEqualScale:isEqualScale
                                    isCircle:isCircle];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius {
    return [self hyb_imageWithColor:color
                             toSize:targetSize
                       cornerRadius:cornerRadius
                    backgroundColor:[UIColor whiteColor]];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor {
    return [self hyb_imageWithColor:color
                             toSize:targetSize
                       cornerRadius:cornerRadius
                    backgroundColor:backgroundColor
                        borderColor:nil
                        borderWidth:0];
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    UIGraphicsBeginImageContextWithOptions(targetSize, cornerRadius == 0, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    UIImage *finalImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (cornerRadius == 0) {
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextFillRect(context, targetRect);
            
            targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
            CGContextStrokeRect(context, targetRect);
        } else {
            CGContextFillRect(context, targetRect);
        }
    } else {
        targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextDrawPath(context, kCGPathFillStroke);
        } else {
            CGContextDrawPath(context, kCGPathFill);
        }
    }
    
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}

+ (UIImage *)hyb_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize {
    return [self hyb_imageWithColor:color toSize:targetSize cornerRadius:0];
}

#pragma mark - Private
- (UIImage *)hyb_private_clipImageToSize:(CGSize)targetSize
                            cornerRadius:(CGFloat)cornerRadius
                                 corners:(UIRectCorner)corners
                         backgroundColor:(UIColor *)backgroundColor
                            isEqualScale:(BOOL)isEqualScale
                                isCircle:(BOOL)isCircle {
    if (targetSize.width <= 0 || targetSize.height <= 0) {
        return self;
    }
    //  NSTimeInterval timerval = CFAbsoluteTimeGetCurrent();
    
    CGSize imgSize = self.size;
    
    CGSize resultSize = targetSize;
    if (isEqualScale) {
        CGFloat x = MAX(targetSize.width / imgSize.width, targetSize.height / imgSize.height);
        resultSize = CGSizeMake(x * imgSize.width, x * imgSize.height);
    }
    
    CGRect targetRect = (CGRect){0, 0, resultSize.width, resultSize.height};
    
    if (isCircle) {
        CGFloat width = MIN(resultSize.width, resultSize.height);
        targetRect = (CGRect){0, 0, width, width};
    }
    
    CGFloat pathWidth = self.hyb_pathWidth;
    CGFloat borderWidth = self.hyb_borderWidth;
    
    if (pathWidth > 0 && borderWidth > 0 && (isCircle || cornerRadius == 0)) {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIColor *borderColor = self.hyb_borderColor;
        UIColor *pathColor = self.hyb_pathColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += pathWidth;
        rectImage.origin.y += pathWidth;
        rectImage.size.width -= pathWidth * 2.0;
        rectImage.size.height -= pathWidth * 2.0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        if (isCircle) {
            CGContextAddEllipseInRect(ctx, rect);
        } else {
            CGContextAddRect(ctx, rect);
        }
        
        CGContextClip(ctx);
        [self drawInRect:rectImage];
        
        // 添加内线和外线
        rectImage.origin.x -= borderWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0;
        rectImage.size.width += borderWidth;
        rectImage.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        if (isCircle) {
            CGContextStrokeEllipseInRect(ctx, rectImage);
            CGContextStrokeEllipseInRect(ctx, rect);
        } else if (cornerRadius == 0) {
            CGContextStrokeRect(ctx, rectImage);
            CGContextStrokeRect(ctx, rect);
        }
        
        float centerPathWidth = pathWidth - borderWidth * 2.0;
        if (centerPathWidth > 0) {
            CGContextSetLineWidth(ctx, centerPathWidth);
            CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
            
            rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.size.width += borderWidth + centerPathWidth;
            rectImage.size.height += borderWidth + centerPathWidth;
            
            if (isCircle) {
                CGContextStrokeEllipseInRect(ctx, rectImage);
            } else if (cornerRadius == 0) {
                CGContextStrokeRect(ctx, rectImage);
            }
        }
    } else if (pathWidth > 0 && borderWidth > 0 && cornerRadius > 0 && !isCircle) {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        UIColor *borderColor = self.hyb_borderColor;
        UIColor *pathColor = self.hyb_pathColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += pathWidth;
        rectImage.origin.y += pathWidth;
        rectImage.size.width -= pathWidth * 2.0;
        rectImage.size.height -= pathWidth * 2.0;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        [self drawInRect:rectImage];
        
        // 添加内线和外线
        rectImage.origin.x -= borderWidth / 2.0;
        rectImage.origin.y -= borderWidth / 2.0;
        rectImage.size.width += borderWidth;
        rectImage.size.height += borderWidth;
        
        rect.origin.x += borderWidth / 2.0;
        rect.origin.y += borderWidth / 2.0;
        rect.size.width -= borderWidth;
        rect.size.height -= borderWidth;
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        
        CGFloat minusPath1 = pathWidth / 2;
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius - minusPath1, cornerRadius - minusPath1)];
        CGContextAddPath(ctx, path1.CGPath);
        
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRoundedRect:rect
                                                    byRoundingCorners:corners
                                                          cornerRadii:CGSizeMake(cornerRadius + minusPath1 ,cornerRadius + minusPath1)];
        CGContextAddPath(ctx, path2.CGPath);
        CGContextStrokePath(ctx);
        
        float centerPathWidth = pathWidth - borderWidth * 2.0;
        if (centerPathWidth > 0) {
            CGContextSetLineWidth(ctx, centerPathWidth);
            CGContextSetStrokeColorWithColor(ctx, [pathColor CGColor]);
            
            rectImage.origin.x -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.origin.y -= borderWidth / 2.0 + centerPathWidth / 2.0;
            rectImage.size.width += borderWidth + centerPathWidth;
            rectImage.size.height += borderWidth + centerPathWidth;
            
            UIBezierPath *path3 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                                        byRoundingCorners:corners
                                                              cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(ctx, path3.CGPath);
            CGContextStrokePath(ctx);
        }
    } else if (pathWidth <= 0 && borderWidth > 0 && (cornerRadius > 0 || isCircle)) {
        UIColor *borderColor = self.hyb_borderColor;
        
        CGRect rect = targetRect;
        CGRect rectImage = rect;
        rectImage.origin.x += borderWidth / 2;
        rectImage.origin.y += borderWidth / 2;
        rectImage.size.width -= borderWidth;
        rectImage.size.height -= borderWidth;
        
        UIImage *image = [self _hyb_scaleToSize:rectImage.size backgroundColor:backgroundColor];
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               NO,
                                               [UIScreen mainScreen].scale);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithPatternImage:image].CGColor);
        
        UIBezierPath *path1 = nil;
        if (!isCircle) {
            CGFloat minusPath1 = borderWidth / 2;
            path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                          byRoundingCorners:corners
                                                cornerRadii:CGSizeMake(cornerRadius - minusPath1, cornerRadius - minusPath1)];
        } else {
            path1 = [UIBezierPath bezierPathWithRoundedRect:rectImage
                                          byRoundingCorners:corners
                                                cornerRadii:CGSizeMake(rectImage.size.width / 2, rectImage.size.width / 2)];
        }
        
        CGContextSetStrokeColorWithColor(ctx, [borderColor CGColor]);
        CGContextSetLineWidth(ctx, borderWidth);
        CGContextAddPath(ctx, path1.CGPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    } else {
        UIGraphicsBeginImageContextWithOptions(targetRect.size,
                                               backgroundColor != nil,
                                               [UIScreen mainScreen].scale);
        if (backgroundColor) {
            [backgroundColor setFill];
            CGContextFillRect(UIGraphicsGetCurrentContext(), targetRect);
        }
        
        if (isCircle) {
            CGContextAddPath(UIGraphicsGetCurrentContext(),
                             [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                        cornerRadius:targetRect.size.width / 2].CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        } else if (cornerRadius > 0) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
            CGContextClip(UIGraphicsGetCurrentContext());
        }
        
        [self drawInRect:targetRect];
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //  NSLog(@"time:%f  originalImageSize: %@, targetSize: %@",
    //        CFAbsoluteTimeGetCurrent() - timerval,
    //        NSStringFromCGSize(imgSize),
    //        NSStringFromCGSize(targetSize));
    
    return finalImage;
}

- (UIImage *)_hyb_scaleToSize:(CGSize)size backgroundColor:(UIColor *)backgroundColor {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    
    if (backgroundColor) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    }
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end

