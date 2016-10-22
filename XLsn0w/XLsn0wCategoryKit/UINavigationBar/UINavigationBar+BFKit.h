
@import UIKit;

/**
 *  This category adds some useful methods to UINavigationBar
 */
@interface UINavigationBar (BFKit)

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 */
- (void)setTransparent:(BOOL)transparent;

/**
 *  Set the UINavigationBar to transparent or not
 *
 *  @param transparent YES to set it transparent, NO to not
 *  @param translucent A Boolean value indicating whether the navigation bar is translucent or not
 */
- (void)setTransparent:(BOOL)transparent translucent:(BOOL)translucent;

@end
