
#import "NSDate+XL.h"

@implementation NSDate (XL)

- (BOOL)isSameToDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *compsSelf = [calendar components:unitFlags fromDate:self];
    NSDateComponents *compsOther = [calendar components:unitFlags fromDate:date];
    if(compsSelf.year == compsOther.year &&
       compsSelf.month == compsOther.month &&
       compsSelf.day == compsOther.day) {
        return YES;
    }
    return NO;
}

@end

@implementation NSDate (Convenience)

- (int)year {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return (int)[components year];
}


- (int)month {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return (int)[components month];
}

-(int)day {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return (int)[components day];
}

-(int)firstWeekDayInMonth {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    return (int)[gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}

-(NSDate *)offsetMonth:(int)numMonths {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

-(NSDate *)offsetHours:(int)hours {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //[offsetComponents setMonth:numMonths];
    [offsetComponents setHour:hours];
    //[offsetComponents setMinute:30];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

-(NSDate *)offsetDay:(int)numDays {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    //[offsetComponents setHour:1];
    //[offsetComponents setMinute:30];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}



- (int)numDaysInMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return (int)numberOfDaysInMonth;
}

+(NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: date];
    return [gregorian dateFromComponents:components];
}

+(NSDate *)dateStartOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+(NSDate *)dateEndOfWeek {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                  + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

@end