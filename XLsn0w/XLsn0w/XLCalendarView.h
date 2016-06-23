
#import <UIKit/UIKit.h>
#import "UIColor+XLsn0w.h"
@class XLCalendarView;

#define kVRGCalendarViewTopBarHeight 60
#define kVRGCalendarViewWidth ([UIScreen mainScreen].bounds.size.width)
//屏幕宽/高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//屏幕比率
#define kFitWidth  ([UIScreen mainScreen].bounds.size.width / 375)
#define kFitHeight ([UIScreen mainScreen].bounds.size.height / 667)

#define kVRGCalendarViewDayWidth ((44*375/320)*kFitWidth)
#define kVRGCalendarViewDayHeight ((44*375/320)*kFitHeight)

@protocol XLCalendarViewDelegate <NSObject>

-(void)calendarView:(XLCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated;
-(void)calendarView:(XLCalendarView *)calendarView dateSelected:(NSDate *)date lunarDict:(NSMutableDictionary*) dict;

@end

@interface XLCalendarView : UIView {
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


