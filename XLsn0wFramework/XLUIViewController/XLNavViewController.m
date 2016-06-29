
#import "XLNavViewController.h"

@interface XLNavViewController () <UIGestureRecognizerDelegate>

@end

@implementation XLNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    if(self.navigationController.viewControllers.count > 1){
        [self addNavigationBarBackButton];
    }
    
    if([[self navigationBarRightButtonTitle] length] > 1){
        [self addNavigationBarRightButton];
    }
    
    [self setNavigationBarNeedsDisplay];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - UINavigationController Methods
//重新绘制NavigationBar
- (void)setNavigationBarNeedsDisplay {
    self.navigationController.navigationBar.barTintColor = [self navBarTintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

//返回事件实现
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

//添加返回按钮
- (void)addNavigationBarBackButton {
    UIButton *navBackButton = [self backButton];
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

//返回按钮子类实现
- (UIButton *)backButton{
    return nil;
}

//导航右侧按钮标题
- (NSString *)navigationBarRightButtonTitle{
    return nil;
}

//添加NavigationBar右侧按钮
- (void)addNavigationBarRightButton{
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setTitle:[self navigationBarRightButtonTitle] forState:UIControlStateNormal];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [[self navigationBarRightButtonTitle] boundingRectWithSize:CGSizeMake(300.0, 44.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    btnRight.frame =  CGRectMake(0.0, 0.0, ceilf(size.width) > 44.0 ?ceilf(size.width):44.0, 44.0);
    [btnRight setTitleColor:[self navBarButtonColor] forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    btnRight.titleEdgeInsets = UIEdgeInsetsMake(0.0, 10.0, 0.0, -10.0);
    [btnRight addTarget:self action:@selector(navigationBarRightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

//导航右侧按钮事件(子类实现)
- (void)navigationBarRightButtonAction:(id)rightButton {
    
}

#pragma mark - Custom View Methods
//弹出键盘的响应View,子类重载即可
- (UIView *)keyboardHandlerView {
    return nil;
}

//处理NavgatinBar着色
- (UIColor *)navBarTintColor {
    return [UIColor blueColor];
}

//处理NavigationBar标题颜色
- (UIColor *)navBarTextColor {
    return [UIColor whiteColor];
}

//处理NavigationBar按钮颜色
- (UIColor *)navBarButtonColor {
    return [UIColor whiteColor];
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
