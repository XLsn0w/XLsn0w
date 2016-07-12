
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface XLGuidePage : NSObject

// title image Y position - from top of the screen
// title and description labels Y position - from bottom of the screen
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIImage *titleImage;
@property (nonatomic, assign) CGFloat imgPositionY;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIFont *titleFont;
@property (nonatomic, retain) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) UIFont *descFont;
@property (nonatomic, retain) UIColor *descColor;
@property (nonatomic, assign) CGFloat descPositionY;

// if customView is set - all other properties are ignored
@property (nonatomic, retain) UIView *customView;

+ (XLGuidePage *)page;
+ (XLGuidePage *)pageWithCustomView:(UIView *)customV;

@end

@protocol XLGuidePageViewDelegate <NSObject>

@optional
- (void)introDidFinish;

@end

@interface XLGuidePageView : UIView

@property (nonatomic, assign) id<XLGuidePageViewDelegate> xlDelegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, retain) UIImage *bgImage;
@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, retain) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *bgImageView;
@property (nonatomic, retain) UIImageView *pageBgBack;
@property (nonatomic, retain) UIImageView *pageBgFront;
@property (nonatomic, retain) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;

@end

/*!
 
 if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLaunch"]) {
 
 XLGuidePage *page1 = [XLGuidePage page];
 page1.title = @"视频Video";
 page1.desc = @"更新猎奇、搞笑、女神、热门四大分类视频";
 page1.bgImage = [UIImage imageNamed:@"XL1050.jpg"];
 
 
 XLGuidePage *page2 = [XLGuidePage page];
 page2.title = @"图片Picture";
 page2.desc = @"拥有十大图片分类，浏览下载于一身";
 page2.bgImage = [UIImage imageNamed:@"XL60.jpg"];
 
 
 
 XLGuidePageView *intro = [[XLGuidePageView alloc] initWithFrame:self.view.bounds andPages:@[page1, page2]];
 
 [intro setDelegate:self];
 [intro showInView:self.view animateDuration:0.0];
 
 
 
 [[NSUserDefaults standardUserDefaults] setObject:@"NoFirstLaunch" forKey:@"FirstLaunch"];
 [[NSUserDefaults standardUserDefaults] synchronize];
 

 }
 */
