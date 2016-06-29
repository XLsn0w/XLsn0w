
#import <UIKit/UIKit.h>

@interface XLNavViewController : UIViewController

/*! 重新绘制 navigationBar */
- (void)setNavigationBarNeedsDisplay;

/*! navigationBar 返回事件方法 */
- (void)goBack;

/*! 绘制 */
- (void)addNavigationBarBackButton;

//返回按钮
- (UIButton *)backButton;

//添加NavigationBar右侧按钮
- (void)addNavigationBarRightButton;

//导航右侧按钮标题
- (NSString *)navigationBarRightButtonTitle;

//导航右侧按钮事件(子类实现)
- (void)navigationBarRightButtonAction:(id)rightButton;

//弹出键盘的响应View,子类重载即可
- (UIView *)keyboardHandlerView;

//处理NavgatinBar着色
- (UIColor *)navBarTintColor;

//处理NavigationBar标题颜色
- (UIColor *)navBarTextColor;

//处理NavigationBar按钮颜色
- (UIColor *)navBarButtonColor;

@end
