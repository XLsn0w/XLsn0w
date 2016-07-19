
#import "XLSegmentedSlideView.h"

@interface XLSegmentedSlideView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation XLSegmentedSlideView

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles {
    if ([super initWithFrame:frame]) {
        _titles  = [titles copy];
         [self drawSegmentedControl];
         [self drawBottomScrollview];
    }
    return self;
}

- (void)drawSegmentedControl {
    self.segmentedControl = [[XLSegmentedControl alloc] init];
    [self addSubview:_segmentedControl];
    self.segmentedControl.frame = CGRectMake(0, 0, self.frame.size.width, 44);
    
    [self.segmentedControl setSectionTitles:_titles];
    self.segmentedControl.type = SegmentedControlTypeText;
    self.segmentedControl.selectionStyle = SegmentedControlSelectionStyleBox;
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blackColor]};
    self.segmentedControl.backgroundColor = [UIColor lightGrayColor];
    self.segmentedControl.selectionIndicatorLocation = SegmentedControlSelectionIndicatorLocationUp;
    self.segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor redColor];
    self.segmentedControl.selectionIndicatorHeight = 1.5;
    self.segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 0, -8, 0);
    
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.segmentedControl addTarget:self action:@selector(selectedSegmentIndex:) forControlEvents:UIControlEventValueChanged];
}

- (void)selectedSegmentIndex:(XLSegmentedControl *)segmentedControl {
    NSInteger selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    
    CGFloat contentOffsetX = self.frame.size.width * selectedSegmentIndex;
    
    [_bottomScrollview setContentOffset:CGPointMake(contentOffsetX, 0)];
    
    [self.xlDelegate slideAndClickActionWithIndex:selectedSegmentIndex];
}

- (void)drawBottomScrollview {
    _bottomScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44)];
    _bottomScrollview.bounces = NO;
    _bottomScrollview.delegate = self;
    _bottomScrollview.backgroundColor = [UIColor whiteColor];
    _bottomScrollview.pagingEnabled = YES;
    _bottomScrollview.showsHorizontalScrollIndicator = NO;
    [self addSubview:_bottomScrollview];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.segmentedControl setSelectedSegmentIndex:currentPage];
    [self.xlDelegate slideAndClickActionWithIndex:currentPage];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.segmentedControl setSelectedSegmentIndex:currentPage];
    [self.xlDelegate slideAndClickActionWithIndex:currentPage];
}

@end
