
#import <UIKit/UIKit.h>

@interface UIFont (XLsn0w)
/**
 *  根据不同的设置返回不同的字体
 */
+ (UIFont *)fontWithDevice:(CGFloat)fontSize;
/**
 *  导航栏根据不同的设置返回不同的字体
 */
+ (UIFont *)navItemFontWithDevice:(CGFloat)fontSize;
/**
 *  根据两行文字设置返回不同的字体
 */
+ (UIFont *)fontWithTwoLine:(CGFloat)fontSize;
/**
 *  保险页面cell字体
 */
+ (UIFont *)insuranceCellFont:(CGFloat)fontSize;
/**
 *  专门为客户性别，年龄电话写的
 */
+ (UIFont *)fontWithCustomer:(CGFloat)fontSize;
@end
