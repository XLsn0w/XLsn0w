
#import <UIKit/UIKit.h>

@interface UIImage (XLsn0w)

/**
 *  Create a pure color image only use the code
 *
 *  @param size  Size of the image
 *  @param color Pure color of the image
 *
 *  @return created image 
 */
+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size andColor:(UIColor *)color;

/**
 *  Create a arrow image use CoreGraphics methods.
 *
 *  @param color The arrow color.
 *
 *  @return The arrow image.
 */
+ (UIImage *)xlsn0w_navigtionBarBackButtonImage:(UIColor *)color;

@end

@interface UIImage (imageNamed)

// 如果跟系统方法差不多功能,可以采取添加前缀,与系统方法区分
+ (UIImage *)log_imageWithName:(NSString *)imageName;

@end

@interface UIImage (StretchSize)

/** 返回一张图片，按指定方式拉伸的图片：width * 0.5 : height * 0.5 */
+ (UIImage *)stretchImageSizeWithName:(NSString *)name;

/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)xlsn0w_getBlurImage:(UIImage *)image blur:(CGFloat)blur;

/**
 *  根据颜色生成一张图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (UIImage *)xlsn0w_getImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)xlsn0w_getCircleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

