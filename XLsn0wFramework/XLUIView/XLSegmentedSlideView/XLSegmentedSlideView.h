
#import <UIKit/UIKit.h>
#import "XLSegmentedControl.h"

@protocol XLSegmentedSlideViewDelegate <NSObject>

- (void)slideAndClickActionWithIndex:(NSInteger)index;

@end

@interface XLSegmentedSlideView : UIView

@property (nonatomic, weak) id<XLSegmentedSlideViewDelegate> xlDelegate;

@property (nonatomic, strong) XLSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *bottomScrollview;

- (instancetype)initWithFrame:(CGRect)frame forTitles:(NSArray *)titles;

@end






