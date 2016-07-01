
#import "XLNavViewController.h"

@interface XLNavViewController () <UIGestureRecognizerDelegate>

@end

@implementation XLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavigationBarUI];
}

#pragma mark - draw NavigationBar UI

/*! 绘制XLNavViewController NavigationBarUI */
- (void)drawNavigationBarUI {
    if(self.navigationController.viewControllers.count > 1){
        [self drawNavigationBarBackButton];
    }
    if([self setNavigationBarRightButtonTitle].length > 1){
        [self drawNavigationBarRightButton];
    }
    [self setNavigationBarNeedsDisplay];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - set NavigationBar NeedsDisplay

/*! 重新绘制 navigationBar */
- (void)setNavigationBarNeedsDisplay {
    self.navigationController.navigationBar.barTintColor = [self setNavBarBackgroundColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[self setNavBarTitleColor]}];
}

#pragma mark - NavigationBar 返回(左侧)按钮

/*! 绘制NavigationBar 返回按钮 */
- (void)drawNavigationBarBackButton {
    UIButton *navBackButton = [self setBackButton];
    if(!navBackButton){
        navBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        navBackButton.frame = CGRectMake(0.0, 0.0, 44.0, 44.0);
        /*! 自定义返回按钮 设置成图片 */
        [navBackButton setImage:[UIImage imageNamed:@"navBackButton"] forState:(UIControlStateNormal)];
        navBackButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, -16.0, 0.0, 16.0);
    }
    [navBackButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navBackButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

/*! navigationBar 返回事件方法 */
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/*! 返回按钮(子类实现) */
- (UIButton *)setBackButton {
    return nil;
}

#pragma mark - NavigationBar 右侧按钮

/*! 绘制NavigationBar 右侧按钮 */
- (void)drawNavigationBarRightButton{
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setTitle:[self setNavigationBarRightButtonTitle] forState:UIControlStateNormal];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [[self setNavigationBarRightButtonTitle] boundingRectWithSize:CGSizeMake(300.0, 44.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    btnRight.frame =  CGRectMake(0.0, 0.0, ceilf(size.width) > 44.0 ?ceilf(size.width):44.0, 44.0);
    [btnRight setTitleColor:[self setNavBarButtonTitleColor] forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    btnRight.titleEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 0.0, -10.0);
    [btnRight addTarget:self action:@selector(handleNavigationBarRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

/*! 设置NavigationBar 右侧按钮文字 */
- (NSString *)setNavigationBarRightButtonTitle {
    return nil;
}

/*! 处理NavigationBar 右侧按钮事件(子类实现) */
- (void)handleNavigationBarRightButtonAction:(id)sender {
    
}

#pragma mark - NavgatinBar 颜色

/*! 处理NavgatinBar 背景色 */
- (UIColor *)setNavBarBackgroundColor {
    return [UIColor blueColor];
}

/*! 处理NavigationBar 标题颜色 */
- (UIColor *)setNavBarTitleColor {
    return [UIColor whiteColor];
}

/*! 处理NavigationBar 按钮文字颜色 */
- (UIColor *)setNavBarButtonTitleColor {
    return [UIColor whiteColor];
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
