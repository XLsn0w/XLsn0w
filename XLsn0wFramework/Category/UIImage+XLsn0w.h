
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
+ (UIImage *)wg_imageWithName:(NSString *)imageName;

@end

/**
 *	图片裁剪处理扩展，支持任意圆角剪裁、生成圆形图片、裁剪成指定大小
 *  支持背景色设置。
 *  支持根据颜色生成纯色图片且支持带圆角。
 */
@interface UIImage (ImageCliped)

#pragma mark - 边框相关属属性，仅对生成圆形图片和矩形图片有效
/**
 *	默认为0，当<=0时，不会添加边框
 */
@property (nonatomic, assign) CGFloat xl_borderWidth;
/**
 *	当小于0时，不会添加边框。默认为0.仅对生成圆形图片和矩形图片有效。要求pathwidth > 2*borderwidth，否则只添加border而无path
 */
@property (nonatomic, assign) CGFloat xl_pathWidth;
/**
 *	边框线的颜色，默认为[UIColor lightGrayColor]，仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *xl_borderColor;
/**
 *	Path颜色，默认为白色。仅对生成圆形图片和矩形图片有效
 */
@property (nonatomic, strong) UIColor *xl_pathColor;

#pragma mark - 根据颜色生成图片
/**
 *	根据颜色生成矩形图片
 *
 *	@param color			待生成的图片颜色
 *	@param targetSize	生成的图片大小
 *
 *	@return 图片对象
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize;

/**
 *	根据颜色生成带圆角的图片。当有圆角时，默认被裁剪的圆角部分的颜色为白色。
 *
 *	@param color				待生成的图片颜色
 *	@param targetSize		生成的图片大小
 *	@param cornerRadius	圆角大小
 *
 *	@return 图片对象
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;

/**
 *	根据颜色生成带圆角的图片
 *
 *	@param color					待生成的图片颜色
 *	@param targetSize			生成的大小
 *	@param cornerRadius		圆角大小
 *	@param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *
 *	@return 带圆角的图片对象
 */
+ (UIImage *)xl_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor;

// 增加带边框颜色图片
+ (UIImage *)xl_imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth;

#pragma mark - 放大或者缩小图片
/**
 *	将图片裁剪成指定大小，没有任何圆角，只是单纯的放大或者缩小图片，以降低内存的使用
 *
 *	@param targetSize 裁剪后的图片大小
 *  @param isEqualScale 是否是等比例缩放
 *
 *	@return 裁剪后的图片
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               isEqualScale:(BOOL)isEqualScale;

#pragma mark - 生成四个圆角图片
/**
 *	将图片裁剪成指定大小，可以指定四个圆角值，背景颜色（与控件的背景颜色一致可解决图层混合问题）
 *
 *	@param targetSize      裁剪后的图片大小
 *	@param cornerRadius		 图片的四个圆角值
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成带圆角图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius;

#pragma mark - 生成任意圆角的图片
/**
 *	@author huangyibiao
 *
 *	生成带任意圆角的图片，可指定上、下、左、右
 *
 *	@param targetSize			  裁剪后的图片大小
 *	@param cornerRadius     圆角值，如果为0，表示不添加
 *	@param corners					指定哪些圆角，如果是左上、右上，可这样：UIRectCornerTopLeft | UIRectCornerTopRight
 *                          如果是全加圆角，使用UIRectCornerAllCorners
 *	@param backgroundColor  背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return 剪裁后的图片
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale;
/**
 * 生成任意带圆角的图片，默认为白色背景，isEqualScale=YES
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners;

#pragma mark - 生成圆形图片
/**
 *	将图片裁剪成圆形
 *
 *	@param targetSize			  裁剪后的图片大小.如果宽与高不相等，会通过isMax参数决定
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale			是否是等比例压缩
 *
 *	@return 圆形图片对象
 */
- (UIImage *)xl_clipCircleToSize:(CGSize)targetSize
                  backgroundColor:(UIColor *)backgroundColor
                     isEqualScale:(BOOL)isEqualScale;
/**
 * 生成圆形图片，默认为白色背景、isEqualScale为YES
 */
- (UIImage *)xl_clipCircleToSize:(CGSize)targetSize;

#pragma mark - 最完整的API
/**
 *	剪裁图片为任意指定圆角。isCircle的优化级最高，其次是cornerRadius，最后才是corners。
 *
 *	@param targetSize			  裁剪成指定的大小
 *	@param cornerRadius		  圆角大小
 *	@param corners					哪些圆角，多个圆角可用 | 来连接
 *	@param backgroundColor	背景颜色。比如整个背景是白色的，则应该传白色过来，与控件的背景颜色一致可解决图层混合问题
 *	@param isEqualScale     是否是等比例压缩
 *	@param isCircle					是否剪裁成圆。优化级最高。若为YES，生成的是圆形图片。
 *
 *	@return 剪裁后的图片
 */
- (UIImage *)xl_clipToSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
            backgroundColor:(UIColor *)backgroundColor
               isEqualScale:(BOOL)isEqualScale
                   isCircle:(BOOL)isCircle;

@end
