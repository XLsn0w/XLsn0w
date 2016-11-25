

#import "NSData+BFKit.h"

@implementation NSData (BFKit)

+ (NSString * _Nonnull)convertToUTF8String:(NSData * _Nonnull)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString * _Nonnull)convertToUTF8String {
    return [NSData convertToUTF8String:self];
}

+ (NSString * _Nonnull)convertToASCIIString:(NSData * _Nonnull)data {
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

- (NSString * _Nonnull)convertToASCIIString {
    return [NSData convertToASCIIString:self];
}

- (NSString * _Nullable)convertUUIDToString {
    return [[[self description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
