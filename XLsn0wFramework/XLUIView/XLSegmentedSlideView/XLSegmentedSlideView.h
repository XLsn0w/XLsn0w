
#import <UIKit/UIKit.h>
#import "XLSegmentedControl.h"
#import "XLRecycleTableView.h"

#define SCREEN_WIDTH_YLSLIDE  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT_YLSLIDE [UIScreen mainScreen].bounds.size.height
#define SET_COLOS_YLSLIDE(R,G,B) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1.0]

#define __WEAK_SELF_YLSLIDE     __weak typeof(self) weakSelf = self;
#define __STRONG_SELF_YLSLIDE   __strong typeof(weakSelf) strongSelf = weakSelf;

@class XLSegmentedSlideView;

#pragma mark YLSlideViewDelegate

/*YLSlideView delegate 方法，设置重用 Cell 和需要创建的页面数 ，在此没有区分 
 dataSource 和 view delegate 。统一实现 YLSlideViewDelegate
 */
@protocol XLSegmentedSlideViewDelegate <NSObject>

@required
/**
 *  需要创建的页面数量
 */
- (NSInteger)columnNumber;

/**
 *  创建Cell方法，使用重用机制。目前在此处只针对UITableView，有特殊需求的可自行进行修改
 *
 *  @param slideView
 *  @param index     页面相对应的索引路径
 *
 *  @return Cell
 */
- (XLRecycleTableView *)slideView:(XLSegmentedSlideView *)slideView cellForRowAtIndex:(NSUInteger)index;

/**
 *  当 cell 初始化完成时调用
 *  可以做预加载显示缓存数据
 *
 *  @param cell
 *  @param index
 */
- (void)slideViewInitiatedComplete:(XLRecycleTableView *)recycleTableView forIndex:(NSUInteger)index;
@optional

/**
 *  返回当前页码
 *
 *  @param index 页码
 */
- (void)slideVisibleView:(XLRecycleTableView *)recycleTableView forIndex:(NSUInteger)index;

@end

#pragma mark YLSlideView
@interface XLSegmentedSlideView : UIView

@property (nonatomic,weak) id<XLSegmentedSlideViewDelegate> xlDelegate;

/*做这种类型自定义需求比较高，在此就没提供更多方便的接口。
 mainScrollview 装栽所有Cell 的一个集合容器
 slideTitleView titles 栏目的容器集合
 */
@property (nonatomic, strong) UIScrollView *mainScrollview;
@property (nonatomic, strong) XLSegmentedControl *segmentedControl;

// default NO 是否显示滚动条
@property (nonatomic,assign) BOOL showsScrollViewHorizontalScrollIndicator;

/**
 *  初始化方法
 *
 *  @param frame
 *  @param titles headView的内容标题
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles;

/**
 *  重置数据
 */
- (void)reloadData;

/**
 *  重用
 *
 *  @return 可重用的Cell
 */
- (XLRecycleTableView *)dequeueRecycleTableView;

@end






