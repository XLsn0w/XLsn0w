

#import "NSNumber+BFKit.h"

@implementation NSNumber (BFKit)

#if __cplusplus
extern "C" {
#endif
CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};
CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
};
#if _cplusplus
}
#endif

+ (NSInteger)randomIntBetweenMin:(NSInteger)minValue andMax:(NSInteger)maxValue {
    return (NSInteger)(minValue + [self randomFloat] * (maxValue - minValue));
}

+ (CGFloat)randomFloat {
    return (float) arc4random() / UINT_MAX;
}

+ (CGFloat)randomFloatBetweenMin:(CGFloat)minValue andMax:(CGFloat)maxValue {
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (maxValue - minValue)) + minValue;
}

+ (NSInteger)nextPowerOfTwo:(NSInteger)number {
    int result = 1;
    while (result < number) {
        result *= 2;
    }
    return result;
}

+ (BOOL)isPowerOfTwo:(NSInteger)number {
    return ((number != 0) && !(number & (number - 1)));
}

@end
