
@import Foundation;
@import UIKit;

/**
 *  This category adds some useful methods to UIScrollView
 */
@interface UIScrollView (BFKit)

/**
 *  Create an UIScrollView and set some parameters
 *
 *  @param frame                ScrollView's frame
 *  @param contentSize          ScrollView's content size
 *  @param clipsToBounds        Set if ScrollView has to clips to bounds
 *  @param pagingEnabled        Set if ScrollView has paging enabled
 *  @param showScrollIndicators Set if ScrollView has to show the scroll indicators, vertical and horizontal
 *  @param delegate             ScrollView's delegate
 *
 *  @return Returns the created UIScrollView
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                             contentSize:(CGSize)contentSize
                           clipsToBounds:(BOOL)clipsToBounds
                           pagingEnabled:(BOOL)pagingEnabled
                    showScrollIndicators:(BOOL)showScrollIndicators
                                delegate:(id<UIScrollViewDelegate> _Nullable)delegate;

@end
