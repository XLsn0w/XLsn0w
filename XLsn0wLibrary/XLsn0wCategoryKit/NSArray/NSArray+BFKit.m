

#import "NSArray+BFKit.h"

@implementation NSArray (BFKit)

- (id _Nullable)safeObjectAtIndex:(NSUInteger)index {
    if ([self count] > 0 && [self count] > index) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSArray * _Nonnull)reversedArray {
    return [NSArray reversedArray:self];
}

- (NSString * _Nonnull)arrayToJson {
    return [NSArray arrayToJson:self];
}

- (NSInteger)superCircle:(NSInteger)index maxSize:(NSInteger)maxSize {
    if (index < 0) {
        index = index % maxSize;
        index += maxSize;
    }
    if (index >= maxSize) {
        index = index % maxSize;
    }
    
    return index;
}

- (id _Nullable)objectAtCircleIndex:(NSInteger)index {
    return [self objectAtIndex:[self superCircle:index maxSize:self.count]];
}

+ (NSString * _Nonnull)arrayToJson:(NSArray * _Nonnull)array {
    NSString *json = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:&error];
    if (!error) {
        json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

+ (NSArray * _Nonnull)reversedArray:(NSArray * _Nonnull)array {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator) [arrayTemp addObject:element];
    
    return arrayTemp;
}

@end
