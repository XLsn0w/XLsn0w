

@import Foundation;
@import UIKit;

/**
 *  This category adds some useful methods to UIWebView
 */
@interface UIWebView (BFKit)

/**
 *  Remove the background shadow of the UIWebView
 */
- (void)removeBackgroundShadow;

/**
 *  Load the requested website
 *
 *  @param website Website to load
 */
- (void)loadWebsite:(NSString * _Nonnull)website;

@end
