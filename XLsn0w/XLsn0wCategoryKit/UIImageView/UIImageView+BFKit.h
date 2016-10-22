

@import Foundation;
@import UIKit;
@import QuartzCore;

/**
 *  This category adds some useful methods to UIImageView
 */
@interface UIImageView (BFKit)

/**
 *  Create an UIImageView with the given image and frame
 *
 *  @param image UIImageView image
 *  @param rect  UIImageView frame
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image
                                 frame:(CGRect)rect;

/**
 *  Create an UIImageView with the given image, size and center
 *
 *  @param image  UIImageView image
 *  @param size   UIImageView size
 *  @param center UIImageView center
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image
                                  size:(CGSize)size
                                center:(CGPoint)center;

/**
 *  Create an UIImageView with the given image and center
 *
 *  @param image  UIImageView image
 *  @param center UIImageView center
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype _Nonnull)initWithImage:(UIImage * _Nonnull)image
                                center:(CGPoint)center;

/**
 *  Create an UIImageView with an image and use it as a template with the given color
 *
 *  @param image     UIImageView image
 *  @param tintColor UIImageView tint color
 *
 *  @return Returns the created UIImageView
 */
+ (instancetype _Nonnull)initWithImageAsTemplate:(UIImage * _Nonnull)image
                                       tintColor:(UIColor * _Nonnull)tintColor;

/**
 *  Create a drop shadow effect
 *
 *  @param color   Shadow's color
 *  @param radius  Shadow's radius
 *  @param offset  Shadow's offset
 *  @param opacity Shadow's opacity
 */
- (void)setImageShadowColor:(UIColor * _Nonnull)color
                        radius:(CGFloat)radius
                        offset:(CGSize)offset
                        opacity:(CGFloat)opacity;

/**
 *  Mask the current UIImageView with an UIImage
 *
 *  @param image The mask UIImage
 */
- (void)setMaskImage:(UIImage * _Nonnull)image;

@end
