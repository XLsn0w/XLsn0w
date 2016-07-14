
#import <UIKit/UIKit.h>

@interface XLScrollView : UIScrollView

@end

/**************************************************************************************************/

@class XLSegmentedControl;

typedef void (^IndexChangeBlock)(NSInteger index);
typedef NSAttributedString *(^TitleFormatterBlock)(XLSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected);

/*! SelectionStyle */
typedef enum {
    SegmentedControlSelectionStyleTextWidthStripe,
    SegmentedControlSelectionStyleFullWidthStripe,
    SegmentedControlSelectionStyleBox,
    SegmentedControlSelectionStyleArrow
} SegmentedControlSelectionStyle;

/*! IndicatorLocation */
typedef enum {
    SegmentedControlSelectionIndicatorLocationUp,
    SegmentedControlSelectionIndicatorLocationDown,
	SegmentedControlSelectionIndicatorLocationNone
} SegmentedControlSelectionIndicatorLocation;

/*! SegmentWidthStyle */
typedef enum {
    SegmentedControlSegmentWidthStyleFixed,
    SegmentedControlSegmentWidthStyleDynamic,
} SegmentedControlSegmentWidthStyle;

typedef NS_OPTIONS(NSInteger, HMSegmentedControlBorderType) {
    SegmentedControlBorderTypeNone = 0,
    SegmentedControlBorderTypeTop = (1 << 0),
    SegmentedControlBorderTypeLeft = (1 << 1),
    SegmentedControlBorderTypeBottom = (1 << 2),
    SegmentedControlBorderTypeRight = (1 << 3)
};

enum {
    SegmentedControlNoSegment = -1   // Segment index for no selected segment
};

/*! Type */
typedef enum {
    SegmentedControlTypeText,
    SegmentedControlTypeImages,
	SegmentedControlTypeTextImages
} SegmentedControlType;

@interface XLSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;

/**
 Provide a block to be executed when selected index is changed.
 
 Alternativly, you could use `addTarget:action:forControlEvents:`
 */
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

/**
 Used to apply custom text styling to titles when set.
 
 When this block is set, no additional styling is applied to the `NSAttributedString` object returned from this block.
 */
@property (nonatomic, copy) TitleFormatterBlock titleFormatter;

/**
 Text attributes to apply to item title text.
 */
@property (nonatomic, strong) NSDictionary *titleTextAttributes UI_APPEARANCE_SELECTOR;

/*
 Text attributes to apply to selected item title text.
 
 Attributes not set in this dictionary are inherited from `titleTextAttributes`.
 */
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes UI_APPEARANCE_SELECTOR;

/**
 Segmented control background color.
 
 Default is `[UIColor whiteColor]`
 */
@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;

/**
 Color for the selection indicator stripe/box
 
 Default is `R:52, G:181, B:229`
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor UI_APPEARANCE_SELECTOR;

/**
 Color for the vertical divider between segments.
 
 Default is `[UIColor blackColor]`
 */
@property (nonatomic, strong) UIColor *verticalDividerColor UI_APPEARANCE_SELECTOR;

/**
 Opacity for the seletion indicator box.
 
 Default is `0.2f`
 */
@property (nonatomic) CGFloat selectionIndicatorBoxOpacity;

/**
 Width the vertical divider between segments that is added when `verticalDividerEnabled` is set to YES.
 
 Default is `1.0f`
 */
@property (nonatomic, assign) CGFloat verticalDividerWidth;

/**
 Specifies the style of the control
 
 Default is `HMSegmentedControlTypeText`
 */
@property (nonatomic, assign) SegmentedControlType type;

/**
 Specifies the style of the selection indicator.
 
 Default is `HMSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) SegmentedControlSelectionStyle selectionStyle;

/**
 Specifies the style of the segment's width.
 
 Default is `HMSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) SegmentedControlSegmentWidthStyle segmentWidthStyle;

/**
 Specifies the location of the selection indicator.
 
 Default is `HMSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) SegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Specifies the border type.
 
 Default is `HMSegmentedControlBorderTypeNone`
 */
@property (nonatomic, assign) HMSegmentedControlBorderType borderType;

/**
 Specifies the border color.
 
 Default is `[UIColor blackColor]`
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 Specifies the border width.
 
 Default is `1.0f`
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user.
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/**
 Default is YES. Set to NO to deny any touch events by the user.
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;

/**
 Default is NO. Set to YES to show a vertical divider between the segments.
 */
@property(nonatomic, getter = isVerticalDividerEnabled) BOOL verticalDividerEnabled;

/**
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/**
 Height of the selection indicator. Only effective when `HMSegmentedControlSelectionStyle` is either `HMSegmentedControlSelectionStyleTextWidthStripe` or `HMSegmentedControlSelectionStyleFullWidthStripe`.
 
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/**
 Edge insets for the selection indicator.
 NOTE: This does not affect the bounding box of HMSegmentedControlSelectionStyleBox
 
 When HMSegmentedControlSelectionIndicatorLocationUp is selected, bottom edge insets are not used
 
 When HMSegmentedControlSelectionIndicatorLocationDown is selected, top edge insets are not used
 
 Defaults are top: 0.0f
             left: 0.0f
           bottom: 0.0f
            right: 0.0f
 */
@property (nonatomic, readwrite) UIEdgeInsets selectionIndicatorEdgeInsets;

/**
 Inset left and right edges of segments.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/**
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;
- (void)setTitleFormatter:(TitleFormatterBlock)titleFormatter;

@end
