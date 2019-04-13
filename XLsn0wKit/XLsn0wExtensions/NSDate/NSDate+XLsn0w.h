
#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

/**
 *  The simplified date structure
 */
struct BFDateInformation {
    /**
     *  Year
     */
    NSInteger year;
    /**
     *  Month of the year
     */
    NSInteger month;
    /**
     *  Day of the month
     */
    NSInteger day;
    
    
    /**
     *  Day of the week
     */
    NSInteger weekday;
    
    /**
     *  Hour of the day
     */
    NSInteger hour;
    /**
     *  Minute of the hour
     */
    NSInteger minute;
    /**
     *  Second of the minute
     */
    NSInteger second;
    /**
     *  Nanosecond of the second
     */
    NSInteger nanosecond;
    
};
typedef struct BFDateInformation BFDateInformation;

@interface NSDate (XLsn0w)

// Relative dates from the current date
+ (NSDate *_Nullable) dateTomorrow;
+ (NSDate *_Nullable) dateYesterday;
+ (NSDate *_Nullable) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *_Nullable) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *_Nullable) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *_Nullable) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *_Nullable) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *_Nullable) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *_Nullable) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *_Nullable) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameMonthAsDate: (NSDate *_Nullable) aDate;
- (BOOL) isThisMonth;
- (BOOL) isSameYearAsDate: (NSDate *_Nullable) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *_Nullable) aDate;
- (BOOL) isLaterThanDate: (NSDate *_Nullable) aDate;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *_Nullable) dateByAddingDays: (NSInteger) dDays;
- (NSDate *_Nullable) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *_Nullable) dateByAddingHours: (NSInteger) dHours;
- (NSDate *_Nullable) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *_Nullable) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *_Nullable) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *_Nullable) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *_Nullable) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *_Nullable) aDate;
- (NSInteger) hoursAfterDate: (NSDate *_Nullable) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *_Nullable) aDate;
- (NSInteger) daysAfterDate: (NSDate *_Nullable) aDate;
- (NSInteger) daysBeforeDate: (NSDate *_Nullable) aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

- (BFDateInformation)dateInformation;
- (BFDateInformation)dateInformationWithTimeZone:(NSTimeZone * _Nonnull)timezone;

+ (NSString * _Nonnull)dateInformationDescriptionWithInformation:(BFDateInformation)info dateSeparator:(NSString *_Nullable)dateSeparator usFormat:(BOOL)usFormat nanosecond:(BOOL)nanosecond;

/**
 *  Compare the two days is same date (not include the time).
 *
 *  @param date The other date
 *
 *  @return true/false
 */
- (BOOL)isSameToDate:(NSDate *_Nullable)date;

@end

@interface NSDate (Convenience)

-(NSDate *_Nullable)offsetMonth:(int)numMonths;
-(NSDate *_Nullable)offsetDay:(int)numDays;
-(NSDate *_Nullable)offsetHours:(int)hours;
-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;

+(NSDate *_Nullable)dateStartOfDay:(NSDate *_Nullable)date;
+(NSDate *_Nullable)dateStartOfWeek;
+(NSDate *_Nullable)dateEndOfWeek;

@end

@interface XLDateItem : NSObject

@property (nonatomic, assign) long day;
@property (nonatomic, assign) long hour;
@property (nonatomic, assign) long minute;
@property (nonatomic, assign) long second;

@end

@interface NSDate (Extension)

- (XLDateItem *_Nullable)xl_timeIntervalSinceDate:(NSDate *_Nullable)anotherDate;

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





