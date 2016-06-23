
#import "XLDateTime.h"

@implementation XLDateTime

- (NSDate *)convertDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = self.year;
    components.month = self.month;
    components.day = self.day;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}
@end


