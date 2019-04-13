
#import "NSArray+XLsn0w.h"

@implementation NSArray (XLsn0w)

- (id)xlsn0w_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

@end
