
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (XLsn0w)

typedef NS_OPTIONS(NSUInteger, ViewSeparatorType) {
    ViewSeparatorTypeTop             = 1 << 0,
    ViewSeparatorTypeLeft            = 1 << 1,
    ViewSeparatorTypeBottom          = 1 << 2,
    ViewSeparatorTypeRight           = 1 << 3,
    ViewSeparatorTypeVerticalSide    = 1 << 4,
    ViewSeparatorTypeHorizontalSide  = 1 << 5,
    ViewSeparatorTypeAll             = 1 << 6
};

#ifndef SeparatorWidth
#define SeparatorWidth (1.0/[UIScreen mainScreen].scale)
#endif

/**
 *  Add the separator line on the view
 *
 *  @param type view-separtor-type
 */
- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type;

/**
 *  Add the separator line on the view
 *
 *  @param type  view-separtor-type
 *  @param color line-color
 */
- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color;
- (void)xlsn0w_addSeparatorWithType:(ViewSeparatorType)type withColor:(UIColor *)color;

/**
 *  Add the autolayout separator line on the view.
 *
 *  @param type The view-separator-type.
 */
- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type;

/**
 *  Add the autolayout separator color line on the view.
 *
 *  @param type  The view-separator-type.
 *  @param color The line color.
 */
- (void)xlsn0w_addALSeparatorWithType:(ViewSeparatorType)type color:(UIColor *)color;

/**
 *  Instance a horizontal line with the width
 *
 *  @param width line-width
 *
 *  @return a horizontal line imageView
 */
+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width;

/**
 *  Instance a horizontal line with the width & color
 *
 *  @param width line-width
 *  @param color line-color
 *
 *  @return a horizontal line imageView
 */
+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width color:(UIColor *)color;
+ (UIImageView *)xlsn0w_instanceHorizontalLine:(CGFloat)width andColor:(UIColor *)color;

/**
 *  Instance a vertical line with the height
 *
 *  @param height line-height
 *
 *  @return a vertical line imageView
 */
+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height;

/**
 *   instance a vertical line with the height & color
 *
 *  @param height line-height
 *  @param color linet-color
 *
 *  @return a vertical line imageView
 */
+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height color:(UIColor *)color;
+ (UIImageView *)xlsn0w_instanceVerticalLine:(CGFloat)height andColor:(UIColor *)color;

/**
 *  Show only text HUD View
 *
 *  @param message The message text
 */
- (void)xlsn0w_showMessageHUD:(NSString *)message;

/**
 *  Remove the HUD
 */
- (void)xlsn0w_removeHUD;

/**
 *  Show only text HUD View with class method
 *
 *  @param message message text
 */
+ (void)xlsn0w_showMessage:(NSString *)message;

/**
 *  Show only the HUD View on any parentView
 *
 *  @param message   message text
 *  @param parentView parentView
 */
+ (void)xlsn0w_showMessage:(NSString *)message onParentView:(UIView *)parentView;

/**
 *  Show detail text HUD View
 *
 *  @param message message text
 */
+ (void)xlsn0w_showDetailMessage:(NSString *)message;

/**
 *  Show detail text HUD View on any parentView
 *
 *  @param message   message text
 *  @param parentView parentView
 */
+ (void)xlsn0w_showDetailMessage:(NSString *)message onParentView:(UIView *)parentView;

/**
 *  Get a screenshot from a view with Y offset
 *
 *  @param deltaY offset Y
 *
 *  @return The screenshot image.
 */
- (UIImage *)xlsn0w_screenshotWithOffsetY:(CGFloat)deltaY;

/**
 *  Get a screenshot with all the partern of view.
 *
 *  @return The screenshot image
 */
- (UIImage *)xlsn0w_screenshot;

/*
 * draw layer borderWidth, borderColor, cornerRadius.
 */
- (void)xlsn0w_layerBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius;

/**
 *  Add corner radius layer on the view
 *
 *  @param radius The radius width
 */
- (void)xlsn0w_addCornerRadius:(CGFloat)radius;

- (void)xlsn0w_addBorderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth;

/**
 *  Add corner radius layer on the view with line color
 *
 *  @param radius    The radius width
 *  @param lineColor The line color
 */
- (void)xlsn0w_addCornerRadius:(CGFloat)radius lineColor:(UIColor *)lineColor;
- (void)xlsn0w_addCornerRadius:(CGFloat)radius andLineColor:(UIColor *)lineColor;

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

-(BOOL) containsSubView:(UIView *)subView;
//-(BOOL) containsSubViewOfClassType:(Class)class;

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;

/** tag */
@property (nonatomic, copy) NSString *tagStr;

- (BOOL)isShowOnKeyWindow;

/** X */
@property (nonatomic, assign) CGFloat x;

/** Y */
@property (nonatomic, assign) CGFloat y;

/** Width */
@property (nonatomic, assign) CGFloat width;

/** Height */
@property (nonatomic, assign) CGFloat height;

/** size */
@property (nonatomic, assign) CGSize size;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;


@end
