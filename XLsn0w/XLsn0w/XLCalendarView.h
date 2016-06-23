
#import <UIKit/UIKit.h>
//屏幕宽/高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//屏幕比率
#define kFitWidth  ([UIScreen mainScreen].bounds.size.width / 375)
#define kFitHeight ([UIScreen mainScreen].bounds.size.height / 667)

#define kTopBarHeight 60
#define kDayWidth ((44*375/320)*kFitWidth)
#define kDayHeight ((44*375/320)*kFitHeight)
#import "UIColor+XLsn0w.h"
@class XLCalendarView;

@protocol XLCalendarViewDelegate <NSObject>

-(void)calendarView:(XLCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;

-(void)calendarView:(XLCalendarView *)calendarView dateSelected:(NSDate *)date lunarDict:(NSMutableDictionary *)dict;

@end

@interface XLCalendarView : UIView
{
    NSDate *currentMonth;
    UILabel *labelCurrentMonth;
    BOOL isAnimating;
    BOOL prepAnimationPreviousMonth;
    BOOL prepAnimationNextMonth;
    UIImageView *animationView_A;
    UIImageView *animationView_B;
    NSArray *markedDates;
    NSArray *markedColors;
}

//@property (nonatomic, strong) NSDate      *currentMonth;
//@property (nonatomic, strong) UILabel     *labelCurrentMonth;
//@property (nonatomic, assign) BOOL        isAnimating;
//@property (nonatomic, assign) BOOL        prepAnimationPreviousMonth;
//@property (nonatomic, assign) BOOL        prepAnimationNextMonth;
//@property (nonatomic, strong) UIImageView *animationView_A;
//@property (nonatomic, strong) UIImageView *animationView_B;
//@property (nonatomic, strong) NSArray     *markedDates;
//@property (nonatomic, strong) NSArray     *markedColors;

@property (nonatomic, assign) id<XLCalendarViewDelegate> delegate;
@property (nonatomic, retain) NSDate *currentMonth;
@property (nonatomic, retain) UILabel *labelCurrentMonth;
@property (nonatomic, retain) UIImageView *animationView_A;
@property (nonatomic, retain) UIImageView *animationView_B;
@property (nonatomic, retain) NSArray *markedDates;
@property (nonatomic, retain) NSArray *markedColors;
@property (nonatomic, getter = calendarHeight) float calendarHeight;

@property (nonatomic, retain, getter = selectedDate) NSDate *selectedDate;

-(void)selectDate:(int)date;
-(void)reset;

-(void)markDates:(NSArray *)dates;
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors;

-(void)showNextMonth;
-(void)showPreviousMonth;

-(int)numRows;
-(void)updateSize;
-(UIImage *)drawCurrentState;

@end


