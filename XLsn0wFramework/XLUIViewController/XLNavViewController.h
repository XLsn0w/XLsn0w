
#import <UIKit/UIKit.h>

@interface XLNavViewController : UIViewController

//处理NavgationBar着色
- (UIColor *)navBarTintColor;

//处理NavgationBar标题颜色
- (UIColor *)navBarTextColor;

//处理NavgationBar按钮颜色
- (UIColor *)navBarButtonColor;

#pragma mark - UINavigationController About Methods
//重绘UINavigationBar
- (void)redrawNavigationBar;

//返回事件
- (void)goBack;

//添加返回按钮
- (void)addNavigationBarBackButton;

//返回按钮
- (UIButton *)backButton;

//添加NavigationBar右侧按钮
- (void)addNavigationBarRightButton;

//导航右侧按钮标题
- (NSString *)navigationBarRightButtonTitle;

//导航右侧按钮事件(子类实现)
- (void)navigationBarRightButtonAction:(id)rightButton;

@end
