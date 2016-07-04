#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+XLsn0w.h"

@interface DateItem : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedTextColor;

@end

@class XLCalendarView;
@protocol XLCalendarViewDelegate <NSObject>

@optional
- (void)calendar:(XLCalendarView *)calendarView configureDateItem:(DateItem *)dateItem forDate:(NSDate *)date;
- (BOOL)calendar:(XLCalendarView *)calendarView willSelectDate:(NSDate *)date;
- (void)calendar:(XLCalendarView *)calendarView didSelectDate:(NSDate *)date;
- (BOOL)calendar:(XLCalendarView *)calendarView willDeselectDate:(NSDate *)date;
- (void)calendar:(XLCalendarView *)calendarView didDeselectDate:(NSDate *)date;
- (BOOL)calendar:(XLCalendarView *)calendarView willChangeToMonth:(NSDate *)date;
- (void)calendar:(XLCalendarView *)calendarView didChangeToMonth:(NSDate *)date;
- (void)calendar:(XLCalendarView *)calendarView didLayoutInRect:(CGRect)frame;

@end

typedef enum {
    startSunday = 7,
    startMonday = 1,
} StartDay;

@interface XLCalendarView : UIView

- (id)initWithStartDay:(StartDay)firstDay;
- (id)initWithStartDay:(StartDay)firstDay frame:(CGRect)frame;

@property (nonatomic) StartDay startDay;
@property (nonatomic, strong) NSLocale *locale;

@property (nonatomic, readonly) NSArray *datesShowing;

@property (nonatomic) BOOL onlyShowCurrentMonth;
@property (nonatomic) BOOL adaptHeightToNumberOfWeeksInMonth;

@property (nonatomic, weak) id<XLCalendarViewDelegate> delegate;

// Theming
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *dateOfWeekFont;
@property (nonatomic, strong) UIColor *dayOfWeekTextColor;
@property (nonatomic, strong) UIFont *dateFont;

- (void)setMonthButtonColor:(UIColor *)color;
- (void)setInnerBorderColor:(UIColor *)color;
- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;

- (void)selectDate:(NSDate *)date makeVisible:(BOOL)visible;
- (void)reloadData;
- (void)reloadDates:(NSArray *)dates;

// Helper methods for delegates, etc.
- (BOOL)date:(NSDate *)date1 isSameDayAsDate:(NSDate *)date2;
- (BOOL)dateIsInCurrentMonth:(NSDate *)date;

@end
