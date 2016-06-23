
#import "XLSelectSheet.h"

@implementation XLSelectSheet

- (instancetype)initWithPickerView:(UIPickerView *)pickerView height:(float)height {
    if (self = [super init]) {
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapCancelGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancelGRAction)];
        [self addGestureRecognizer:tapCancelGR];
        
        //ActionSheetView
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 200), [UIScreen mainScreen].bounds.size.width, height)];
        self.backView.backgroundColor = [UIColor whiteColor];
        
        _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _toolbar.barStyle = UIBarStyleDefault;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style: UIBarButtonItemStylePlain target:self action: @selector(completeAction)];
        [doneButton setTintColor:[UIColor blueColor]];
        UIBarButtonItem *cancelButton  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style: UIBarButtonItemStylePlain target:self action: @selector(cancelAction)];
        [cancelButton setTintColor:[UIColor blueColor]];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        NSArray *array = @[cancelButton, spaceItem, spaceItem, spaceItem, spaceItem, doneButton];
        [_toolbar setItems:array];
        
        
        //添加响应事件(如果不加响应事件则传过来的view不显示)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackView)];
        [self.backView addGestureRecognizer:tap];
        [self addSubview:self.backView];
        [self.backView addSubview:_toolbar];
        [self.backView addSubview:pickerView];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-height, [UIScreen mainScreen].bounds.size.width, height)];
            
        } completion:^(BOOL finished) {
            
        }];
    }
    return self;
}

- (void)showInSuperview:(UIView *)view {
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

- (void)tapCancelGRAction {
    [UIView animateWithDuration:0.2 animations:^{
        [self.backView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


- (void)tapBackView {
    
}

- (void)completeAction {
    [self.selectSheetDelegate selectComplete];
    [self tapCancelGRAction];
}

- (void)cancelAction {
    [self.selectSheetDelegate selectComplete];
    [self tapCancelGRAction];
}



@end
