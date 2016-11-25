

#import "NSMutableDictionary+BFKit.h"

@implementation NSMutableDictionary (BFKit)

- (BOOL)safeSetObject:(id _Nonnull)anObject forKey:(id<NSCopying> _Nonnull)aKey {
    if (anObject == nil) {
        return NO;
    }
    
    [self setObject:anObject forKey:aKey];
    
    return YES;
}

@end
