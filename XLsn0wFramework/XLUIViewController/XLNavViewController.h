
#import <UIKit/UIKit.h>

@interface XLNavViewController : UIViewController

#pragma mark - set NavigationBar NeedsDisplay

/*! 重新绘制 navigationBar */
- (void)setNavigationBarNeedsDisplay;

#pragma mark - NavigationBar 返回(左侧)按钮

/*! 绘制NavigationBar 返回按钮 */
- (void)drawNavigationBarBackButton;

/*! navigationBar 返回事件方法 */
- (void)goBack;

/*! 返回按钮(子类实现) */
- (UIButton *)setBackButton;

#pragma mark - NavgatinBar 颜色

/*! 处理NavgatinBar 背景色 */
- (UIColor *)setNavBarBackgroundColor;

/*! 处理NavigationBar 标题颜色 */
- (UIColor *)setNavBarTitleColor;

@end
