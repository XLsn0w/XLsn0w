
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**************************************************************************************************/

@class CAGradientLayer;

@interface CalendarHeader : UIView

@property(nonatomic, strong, readonly) CAGradientLayer *gradientLayer;

- (void)setColors:(NSArray *)colors;

@end

/**************************************************************************************************/

@interface DateCell : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@end

/**************************************************************************************************/
@interface DateButton : UIButton

@property (nonatomic, strong) NSDate *buttonDate;
@property (nonatomic, strong) DateCell *dateCell;
@property (nonatomic, strong) NSCalendar *buttonCalendar;

@end

/********************************XLSignCalendarDelegate********************************************/
@class XLCalendarComponent;
@protocol XLCalendarComponentDelegate <NSObject>

@optional
- (void)calendarComponent:(XLCalendarComponent *)calendarComponent configureDateCell:(DateCell *)dateCell forDate:(NSDate *)date;
- (BOOL)calendarComponent:(XLCalendarComponent *)calendarComponent willSelectDate:(NSDate *)date;
/*! 点击具体日期 */
- (void)calendarComponent:(XLCalendarComponent *)calendarComponent didSelectDate:(NSDate *)date;

- (BOOL)calendarComponent:(XLCalendarComponent *)calendarComponent willDeselectDate:(NSDate *)date;
- (void)calendarComponent:(XLCalendarComponent *)calendarComponent didDeselectDate:(NSDate *)date;
- (BOOL)calendarComponent:(XLCalendarComponent *)calendarComponent willChangeToMonth:(NSDate *)date;
- (void)calendarComponent:(XLCalendarComponent *)calendarComponent didChangeToMonth:(NSDate *)date;
- (void)calendarComponent:(XLCalendarComponent *)calendarComponent didLayoutInRect:(CGRect)frame;

@end

/****************************自定义签到日历组件*******************************************************/

@interface XLCalendarComponent : UIView

/** 当天是否已经签到 */
@property (nonatomic, assign) BOOL isSignForToday;

/*! 自定义代理属性:xlsn0wDelegate */
@property (nonatomic, weak) id<XLCalendarComponentDelegate> xlDelegate;

@property (nonatomic, strong) NSLocale *locale;

@property (nonatomic, readonly) NSArray *datesShowing;

@property (nonatomic) BOOL onlyShowCurrentMonth;
@property (nonatomic) BOOL adaptHeightToNumberOfWeeksInMonth;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *dateOfWeekFont;
@property (nonatomic, strong) UIColor *dayOfWeekTextColor;
@property (nonatomic, strong) UIFont *dateFont;

- (void)setMonthButtonColor:(UIColor *)color;
- (void)setInnerBorderColor:(UIColor *)color;
- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;


- (BOOL)selectDate:(NSDate *)selectDate isEqualToDate:(NSDate *)date;
- (BOOL)dateIsInCurrentMonth:(NSDate *)date;

@end

/*
 //init
 XLCalendarComponent *calendarComponent = [[XLCalendarComponent alloc] init];
 
 //add Subview
 [superView addSubview:calendarComponent];
 
 //set Frame
 [calendarComponent setFrame:CGRectMake(0, 64, kScreenWidth, kScreenWidth)];
 
 //set Delegate
 calendarComponent.xlDelegate = self;
 
 calendarComponent.onlyShowCurrentMonth = NO;
 calendarComponent.adaptHeightToNumberOfWeeksInMonth = YES;
 
 */














