

@import Foundation;
@import CoreGraphics;

/**
 *  This category adds some useful methods to NSNumber
 */
@interface NSNumber (BFKit)

#if __cplusplus
extern "C" {
#endif
/**
 *  Degrees to radians conversion
 *
 *  @param degrees Degrees to be converted
 *
 *  @return Returns the convertion result
 */
CGFloat DegreesToRadians(CGFloat degrees);
/**
 *  Radians to degrees conversion
 *
 *  @param radians Radians to be converted
 *
 *  @return Returns the convertion result
 */
CGFloat RadiansToDegrees(CGFloat radians);
#if __cplusplus
}
#endif

/**
 *  Create a random integer between the given range
 *
 *  @param minValue Mininum random value
 *  @param maxValue Maxinum random value
 *
 *  @return Returns the created random integer
 */
+ (NSInteger)randomIntBetweenMin:(NSInteger)minValue
                          andMax:(NSInteger)maxValue;

/**
 *  Create a random float
 *
 *  @return Returns the created random float
 */
+ (CGFloat)randomFloat;

/**
 *  Create a random float between the given range
 *
 *  @param minValue Mininum random value
 *  @param maxValue Maxinum random value
 *
 *  @return Returns the created random float
 */
+ (CGFloat)randomFloatBetweenMin:(CGFloat)minValue
                          andMax:(CGFloat)maxValue;

/**
 *  Get the next power of two
 *
 *  @param number Number to be powered
 *
 *  @return Returns the number powered
 */
+ (NSInteger)nextPowerOfTwo:(NSInteger)number;

/**
 *  Returns if the number is a power of two
 *
 *  @param number Number to check
 *
 *  @return Returns if the number is a power of two
 */
+ (BOOL)isPowerOfTwo:(NSInteger)number;

@end
