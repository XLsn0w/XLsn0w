

#import <UIKit/UIKit.h>

@interface UIColor (JKHEX)
+ (UIColor *)jk_colorWithHex:(UInt32)hex;
+ (UIColor *)jk_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)jk_colorWithHexString:(NSString *)hexString;
- (NSString *)jk_HEXString;

+ (UIColor *)jk_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue
                         alpha:(CGFloat)alpha;

+ (UIColor *)jk_colorWithWholeRed:(CGFloat)red
                         green:(CGFloat)green
                          blue:(CGFloat)blue;
@end
