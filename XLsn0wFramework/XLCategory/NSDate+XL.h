
#import <Foundation/Foundation.h>

@interface NSDate (XL)

/**
 *  Compare the two days is same date (not include the time).
 *
 *  @param date The other date
 *
 *  @return true/false
 */
- (BOOL)isSameToDate:(NSDate *)date;

@end

@interface NSDate (Convenience)

-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;
-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;

+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

@end

@interface XLDateItem : NSObject

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;

@end

@interface NSDate (Extension)

- (XLDateItem *)xl_timeIntervalSinceDate:(NSDate *)anotherDate;

- (BOOL)xl_isToday;
- (BOOL)xl_isYesterday;
- (BOOL)xl_isTomorrow;
- (BOOL)xl_isThisYear;

//获取今天周几
- (NSInteger)xl_getNowWeekday;

@end

@interface NSDate (CurrentMonth)

/** 获取当前月总共有多少天 */
+ (NSInteger)numberOfDaysInCurrentMonth;
/** 获取当前月中共有多少周 */
+ (NSInteger)numberOfWeeksInCurrentMonth;
/** 获取当前月中第一天在一周内的索引 */
+ (NSInteger)indexOfWeekForFirstDayInCurrentMonth;
/** 获取当天在当月中的索引(第几天) */
+ (NSInteger)indexOfMonthForTodayInCurrentMonth;

@end





