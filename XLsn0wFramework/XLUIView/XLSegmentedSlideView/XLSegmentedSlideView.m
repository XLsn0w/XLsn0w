
#import "XLSegmentedSlideView.h"
#import "XL.h"

static float const kSegmentedControlHeight = 44;

@interface XLSegmentedSlideView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGPoint beginScrollOffset;
@property (nonatomic, assign) NSInteger totaiPageNumber;
@property (nonatomic, strong) NSMutableSet *visibleCells;
@property (nonatomic, strong) NSMutableSet *recycledCells;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSUInteger prePageIndex;

//
- (void)slideViewRecycle;
- (BOOL)isVisibleCellForIndex:(NSUInteger)index;
- (void)drawRecycleTableView:(XLRecycleTableView *)recycleTableView forIndex:(NSUInteger)index;
//
- (void)drawSlideView;

@end

@implementation XLSegmentedSlideView

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles {
    if ([super initWithFrame:frame]) {
        _titles  = [titles copy];
        _prePageIndex = 1000;
        [self drawSlideView];
        //监听Delegate值改变以刷新数据，不想使用者做太多无谓的方法调用
        [self addObserver:self
               forKeyPath:@"xlDelegate"
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"xlDelegate"]) {
        [self reloadData];
    }
}
- (void)dealloc{
    [self removeObserver:self forKeyPath:@"xlDelegate"];
}
#pragma mark RecycledCell

- (void)slideViewRecycle{

    CGRect mainScrollViewBounds = _mainScrollview.bounds;
    
    NSUInteger currentPage = CGRectGetMinX(mainScrollViewBounds)/SCREEN_WIDTH_YLSLIDE;
    
    NSUInteger nextPage    = CGRectGetMaxX(mainScrollViewBounds)/SCREEN_WIDTH_YLSLIDE;
    
    currentPage            = MAX(currentPage, 0);
    nextPage               = MIN(nextPage, _totaiPageNumber-1);
    
    //回收 unvisible cell
    for (XLRecycleTableView * cell  in _visibleCells) {
        
        if (cell.index < currentPage || cell.index > nextPage) {

            //保存偏移量
            [[XLCache sharedCache]setDataToMemoryWithData:[NSStringFromCGPoint(cell.contentOffset) dataUsingEncoding:NSUTF8StringEncoding] forKey:[@(cell.index) stringValue]];
            
            
            [_recycledCells addObject:cell];
            [cell removeFromSuperview];
            
        }
    }
   
    [_visibleCells minusSet:_recycledCells];
    
    // 添加重用Cell
    for (NSUInteger index = currentPage ; index <= nextPage; index++) {
        
        if (![self isVisibleCellForIndex:index]) {
        
           XLRecycleTableView *cell = [_xlDelegate slideView:self cellForRowAtIndex:index];
          
            
            [self drawRecycleTableView:cell forIndex:index];
            
            [_visibleCells addObject:cell];
            
        }
    }
}

- (XLRecycleTableView *)dequeueRecycleTableView {

    XLRecycleTableView * cell = [_recycledCells anyObject];
    
    if (cell) {
        [_recycledCells removeObject:cell];
    }
    
    return cell;
}

- (BOOL)isVisibleCellForIndex:(NSUInteger)index{

    BOOL isVisibleCell = NO;
    
    for (XLRecycleTableView * cell in _visibleCells) {
        
        if (cell.index == index) {
            isVisibleCell = YES;
            break;
        }
        
    }
    return isVisibleCell;
}

- (XLRecycleTableView*)visibleCellForIndex:(NSUInteger)index{

    XLRecycleTableView * visibleCell = nil;
    
    for (XLRecycleTableView * cell in _visibleCells) {
        
        if (cell.index == index) {
            visibleCell = cell;
            break;
        }
    }
    return visibleCell;
}

- (void)drawRecycleTableView:(XLRecycleTableView *)recycleTableView forIndex:(NSUInteger)index {
    
    recycleTableView.index            = index;
    CGRect cellFrame      = self.bounds;
    cellFrame.origin.x    = CGRectGetWidth(self.frame)*index;
    cellFrame.size.height = cellFrame.size.height - kSegmentedControlHeight;
    
    [recycleTableView setFrame:cellFrame];
    [_mainScrollview addSubview:recycleTableView];
    
    if ([_xlDelegate respondsToSelector:@selector(slideViewInitiatedComplete:forIndex:)]) {
        [_xlDelegate slideViewInitiatedComplete:recycleTableView forIndex:index];
    }
    
    //获取偏移量
   __block XLRecycleTableView *newCell = recycleTableView;
    [[XLCache sharedCache] dataForKey:[@(recycleTableView.index) stringValue] block:^(NSData *data, NSString *key) {
        
        if (data) {
            CGPoint offset = CGPointFromString([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            [newCell setContentOffset:offset];
        }
    }];
    
}

#pragma make reloadData

- (void)reloadData{

    [_visibleCells  removeAllObjects];
    [_recycledCells removeAllObjects];
    
    [[XLCache sharedCache]removeMemoryAllData];
    
    __WEAK_SELF_YLSLIDE
    
    if ([_xlDelegate respondsToSelector:@selector(columnNumber)]) {
        
            if (weakSelf) {
                
                __STRONG_SELF_YLSLIDE
                
                _totaiPageNumber = [strongSelf->_xlDelegate columnNumber];

                [strongSelf.mainScrollview setContentSize:CGSizeMake(CGRectGetWidth(strongSelf.frame)*_totaiPageNumber, CGRectGetHeight(strongSelf.frame)-kSegmentedControlHeight)];
                
            }
    }

    [self slideViewRecycle];
    
    [self visibleViewDelegateForIndex:0];


}

- (void)visibleViewDelegateForIndex:(NSUInteger)index{

    if (_prePageIndex != index) {
        if ([_xlDelegate respondsToSelector:@selector(slideVisibleView:forIndex:)]) {
            [_xlDelegate slideVisibleView:[self visibleCellForIndex:index] forIndex:index];
        }
    }
    
    _prePageIndex = index;

}
//屏幕宽/高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
- (void)drawSegmentedControl {
    self.segmentedControl = [[XLSegmentedControl alloc] init];
    [self addSubview:_segmentedControl];
    self.segmentedControl.frame = CGRectMake(0, 0, kScreenWidth, 50);
    
    [self.segmentedControl setSectionTitles:_titles];
    self.segmentedControl.type = SegmentedControlTypeText;
    self.segmentedControl.selectionStyle = SegmentedControlSelectionStyleBox;
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
    self.segmentedControl.backgroundColor = [UIColor lightGrayColor];
    self.segmentedControl.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationUp;
    self.segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor blueColor];
    self.segmentedControl.selectionIndicatorHeight = 1.5;
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, -8, 0);
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentIndex:) forControlEvents:UIControlEventValueChanged];
}

- (void)selectedSegmentIndex:(XLSegmentedControl *)segmentedControl {
    NSInteger selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    
    CGRect frame   = self.mainScrollview.bounds;
    frame.origin.x = CGRectGetWidth(self.frame) * selectedSegmentIndex;
    [self.mainScrollview scrollRectToVisible:frame animated:NO];
    [self visibleViewDelegateForIndex:selectedSegmentIndex];
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   [self slideViewRecycle];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self visibleViewDelegateForIndex:currentPage];
    [self.segmentedControl setSelectedSegmentIndex:currentPage];
}

#pragma mark configSlideView

- (void)drawSlideView {
    
    _visibleCells  = [[NSMutableSet alloc]init];
    _recycledCells = [[NSMutableSet alloc]init];
    
    _mainScrollview = ({
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                                  kSegmentedControlHeight,
                                                                                  CGRectGetWidth(self.frame),
                                                                                  CGRectGetHeight(self.frame)-kSegmentedControlHeight)];
        scrollView.bounces         = NO;
        scrollView.delegate        = self;
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.pagingEnabled   = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        
        scrollView;
    });
    [self addSubview:_mainScrollview];
    [self drawSegmentedControl];
}


#pragma mark Set Get
- (void)setShowsScrollViewHorizontalScrollIndicator:(BOOL)showsScrollViewHorizontalScrollIndicator {
    _mainScrollview.showsHorizontalScrollIndicator = showsScrollViewHorizontalScrollIndicator;

}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com