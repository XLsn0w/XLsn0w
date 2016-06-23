
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
