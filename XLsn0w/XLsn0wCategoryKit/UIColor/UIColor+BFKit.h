

@import Foundation;
@import UIKit;

/**
 *  This category adds some useful methods to UIColor
 *
 *  RGBA(r, g, b, a): Create an UIColor in format RGBA
 *
 *  RBG(r, g, b): Create an UIColor in format RGB
 */
@interface UIColor (BFKit)

/**
 *  RGB properties: red
 */
@property (nonatomic, readonly) CGFloat red;
/**
 *  RGB properties: green
 */
@property (nonatomic, readonly) CGFloat green;
/**
 *  RGB properties: blue
 */
@property (nonatomic, readonly) CGFloat blue;
/**
 *  RGB properties: white
 */
@property (nonatomic, readonly) CGFloat white;
/**
 *  RGB properties: hue
 */
@property (nonatomic, readonly) CGFloat hue;
/**
 *  RGB properties: saturation
 */
@property (nonatomic, readonly) CGFloat saturation;
/**
 *  RGB properties: brightness
 */
@property (nonatomic, readonly) CGFloat brightness;
/**
 *  RGB properties: alpha
 */
@property (nonatomic, readonly) CGFloat alpha;
/**
 *  RGB properties: luminance
 */
@property (nonatomic, readonly) CGFloat luminance;

/**
 *  Create a color from a HEX string.
 *  It supports the following type:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString HEX string
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)hex:(NSString * _Nonnull)hexString;

/**
 *  Create a color from a HEX string.
 *  It supports the following type:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString HEX string
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)hexString:(NSString * _Nonnull)hexString;

/**
 *  Create a color from a HEX string
 *
 *  @param hexString HEX string
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)colorWithHexString:(NSString * _Nonnull)hexString DEPRECATED_MSG_ATTRIBUTE("Use +hex");

/**
 *  Create a color from HEX
 *
 *  @param hex HEX value
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)colorWithHex:(unsigned int)hex;

/**
 *  Create a color from HEX with alpha
 *
 *  @param hex   HEX value
 *  @param alpha Alpha value
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)colorWithHex:(unsigned int)hex
                             alpha:(float)alpha;

/**
 *  Create an UIColor from a given string (blue or ff00ff)
 *
 *  @param colorString String with the color
 *
 *  @return Returns the created UIColor
 */
+ (UIColor * _Nonnull)colorForColorString:(NSString * _Nonnull)colorString;

/**
 *  Create a random color
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)randomColor;

/**
 *  Creates and returns a color object that has the same color space and component values as the given color, but has the specified alpha component
 *
 *  @param color UIColor value
 *  @param alpha Alpha value
 *
 *  @return Returns the UIColor instance
 */
+ (UIColor * _Nonnull)colorWithColor:(UIColor * _Nonnull)color
                               alpha:(float)alpha;

/**
 *  Check if the color is in RGB format
 *
 *  @return Returns if the color is in RGB format
 */
- (BOOL)canProvideRGBComponents;

/**
 *  A good contrasting color, it will be either black or white
 *
 *  @return Returns the color
 */
- (UIColor * _Nonnull)contrastingColor;

/**
 *  A complementary color that should look good
 *
 *  @return Returns the color
 */
- (UIColor * _Nonnull)complementaryColor;

@end
