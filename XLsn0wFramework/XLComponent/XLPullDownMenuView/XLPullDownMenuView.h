
#import <UIKit/UIKit.h>

@protocol XLPullDownMenuViewDelegate <NSObject>

- (void)didSelectXLPullDownMenuWithRow:(NSInteger)row;

@end

@interface XLPullDownMenuView  : UIView

@property (nonatomic, weak) id<XLPullDownMenuViewDelegate> xlDelegate;

/*! 圆角 */
@property (nonatomic) CGFloat cornerRadius;
/*! 边线宽度 */
@property (nonatomic) CGFloat borderWidth;
/*! 边线颜色 */
@property (nonatomic) UIColor *borderColor;
/*! 箭头图片 */
@property (nonatomic) UIImage *arrowImage;
/*! 文字颜色 */
@property (nonatomic) UIColor *textColor;
/*! 测试颜色 */
@property (nonatomic) NSString *testString;
/*! 最大行数 */
@property (nonatomic) NSInteger maxRows;
/*! 下拉数据源 */
@property (strong, nonatomic) NSArray *listItems;
/*! 默认标题 */
@property (nonatomic, strong) NSString *defaultTitle;
/*! 背景颜色 */
@property (nonatomic, strong) UIColor *comBackgroundColor;
/*! 标题大小 */
@property (nonatomic, assign) NSInteger titleSize;
/*! 下拉时选择的事件 */
@property (nonatomic, copy) void (^ClickDropDown)(NSInteger index);
/*! 当前选项值 */
@property (nonatomic, copy, readonly) NSString *value;

- (void)reloadData;
- (void)closeMenu;

@end

/*!
 _workStatus = [[XLPullDownMenuView alloc] initWithFrame:CGRectMake(20, 100, 300, 30)];
 [self.view addSubview:_workStatus];
 _workStatus.listItems = @[@"iOS",@"Java",@"PHP", @"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP",@"iOS",@"Java",@"PHP"];
 _workStatus.maxRows = 10;//设置最大列数
 _workStatus.defaultTitle = @"请选择专业：";//标题
 _workStatus.titleSize = 14;//标题字体大小
 _workStatus.borderColor = [UIColor blackColor];
 _workStatus.borderWidth = 1.0f;
 _workStatus.cornerRadius = 5;
 _workStatus.comBackgroundColor = [UIColor whiteColor];
 __weak typeof(self) weakSelf = self;
 _workStatus.ClickDropDown = ^(NSInteger index){
 NSLog(@"选择了-------------:%@",weakSelf.workStatus.listItems[index]);
 };
 */