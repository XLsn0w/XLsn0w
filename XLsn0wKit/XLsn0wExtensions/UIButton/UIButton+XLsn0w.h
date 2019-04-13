
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XLsn0wButtonImageStyle) {
    XLsn0wButtonImageStyleTop    = 0,  // image在上，label在下 //图片在上，文字在下 默认
    XLsn0wButtonImageStyleLeft   = 1,  // image在左，label在右 //图片在左，文字在右
    XLsn0wButtonImageStyleBottom = 2,  // image在下，label在上 //图片在下，文字在上
    XLsn0wButtonImageStyleRight  = 3   // image在右，label在左 //图片在右，文字在左
};

@interface UIButton (XLsn0w)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(XLsn0wButtonImageStyle)style
                        imageTitleSpace:(CGFloat)space;

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(XLsn0wButtonImageStyle)postion
                 spacing:(CGFloat)spacing;

@end

@interface UIButton (BadgeView)

/**
 *  Remove the badge value on the button.
 */
- (void)xlsn0w_removeBadgeValue;

/**
 *  Add a badge value view on the button.
 *
 *  @param strBadgeValue The badge value.
 *
 *  @return A view contrain the badge value.
 */
- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue;

/**
 *  Add a badage value view use the padding position.
 *
 *  @param strBadgeValue The badge value.
 *  @param point         The padding offset position.
 *
 *  @return A view contrain the badge value.
 */
- (UIView *)xlsn0w_showBadgeValue:(NSString *)strBadgeValue andPadding:(CGPoint)point;

@end


@interface UIButton (XLButtonCenterStyle)

/**
 *  Set the title & image center in the button bounds
 *
 *  @param space The title & image space
 */
- (void)xlsn0w_centerImageAndTitle:(float)space;

/**
 *  Default center method.
 */
- (void)xlsn0w_centerImageAndTitle;

@end

@interface StretchButton : UIButton

@end

@interface UIButton (XLsn0wBadge)

@property (strong, nonatomic) UILabel *badge;

/**
 *  角标显示的信息，可以为数字和文字
 */
@property (nonatomic) NSString *badgeValue;
/**
 *  角标背景颜色，默认为红色
 */
@property (nonatomic) UIColor *badgeBGColor;
/**
 *  角标文字的颜色
 */
@property (nonatomic) UIColor *badgeTextColor;
/**
 *  角标字号
 */
@property (nonatomic) UIFont *badgeFont;
/**
 *  角标的气泡边界
 */
@property (nonatomic) CGFloat badgePadding;
/**
 *  角标的最小尺寸
 */
@property (nonatomic) CGFloat badgeMinSize;
/**
 *  角标的x值
 */
@property (nonatomic) CGFloat badgeOriginX;
/**
 *  角标的y值
 */
@property (nonatomic) CGFloat badgeOriginY;
/**
 *  当角标为0时，自动去除角标
 */
@property BOOL shouldHideBadgeAtZero;
/**
 *  当角标的值发生变化，角标的动画是否显示
 */
@property BOOL shouldAnimateBadge;

@end






