
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
+ (UIImage *)xlsn0w_createImageWithCGSize:(CGSize)size andColor:(UIColor *)color __deprecated_msg("Use `dd_createImageWithCGSize:color:`");

/**
 *  Create a arrow image use CoreGraphics methods.
 *
 *  @param color The arrow color.
 *
 *  @return The arrow image.
 */
+ (UIImage *)xlsn0w_navigtionBarBackButtonImage:(UIColor *)color;

@end
