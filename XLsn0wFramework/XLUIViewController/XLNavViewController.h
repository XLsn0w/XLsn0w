
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

#pragma mark - NavigationBar 右侧按钮

/*! 绘制NavigationBar 右侧按钮 */
- (void)drawNavigationBarRightButton;

/*! 设置NavigationBar 右侧按钮文字 */
- (NSString *)setNavigationBarRightButtonTitle;

/*! 处理NavigationBar 右侧按钮事件(子类实现) */
- (void)handleNavigationBarRightButtonAction:(id)sender;

#pragma mark - NavgatinBar 颜色

//处理NavgatinBar 背景色
- (UIColor *)setNavigationBarBackgroundColor;

/*! 处理NavigationBar 文本颜色 */
- (UIColor *)setNavigationBarTextColor;

/*! 处理NavigationBar 按钮颜色 */
- (UIColor *)setNavigationBarButtonColor;

@end
