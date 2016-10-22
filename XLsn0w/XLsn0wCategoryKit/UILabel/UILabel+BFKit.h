

@import Foundation;
@import UIKit;

#import "UIFont+BFKit.h"
#import "NSString+BFKit.h"

/**
 *  This category adds some useful methods to UILabel
 */
@interface UILabel (BFKit)

/**
 *  Create an UILabel with the given parameters, with clearColor for the shadow
 *
 *  @param frame     Label's frame
 *  @param text      Label's text
 *  @param fontName  Label's font name, FontName enum is declared in UIFont+BFKit
 *  @param size      Label's font size
 *  @param color     Label's text color
 *  @param alignment Label's text alignment
 *  @param lines     Label's text lines
 *
 *  @return Returns the created UILabel
 */
+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame
                               text:(NSString * _Nonnull)text
                               font:(FontName)fontName
                               size:(CGFloat)size
                              color:(UIColor * _Nonnull)color
                          alignment:(NSTextAlignment)alignment
                              lines:(NSInteger)lines;

/**
 *  Create an UILabel with the given parameters
 *
 *  @param frame       Label's frame
 *  @param text        Label's text
 *  @param fontName    Label's font name, FontName enum is declared in UIFont+BFKit
 *  @param size        Label's font size
 *  @param color       Label's text color
 *  @param alignment   Label's text alignment
 *  @param lines       Label's text lines
 *  @param colorShadow Label's text shadow color
 *
 *  @return Returns the created UILabel
 */
+ (UILabel * _Nonnull)initWithFrame:(CGRect)frame
                               text:(NSString * _Nonnull)text
                               font:(FontName)fontName
                               size:(CGFloat)size
                              color:(UIColor * _Nonnull)color
                          alignment:(NSTextAlignment)alignment
                              lines:(NSInteger)lines
                        shadowColor:(UIColor * _Nonnull)colorShadow;


/**
 *  Calculates height based on text, width and font
 *
 *  @return Returns calculated height
 */
- (CGFloat)calculatedHeight;


/**
 *  Sets a custom font from a character at an index to character at another index
 *
 *  @param font      New font to be setted
 *  @param fromIndex The start index
 *  @param toIndex   The end index
 */
- (void)setFont:(UIFont * _Nonnull)font
      fromIndex:(NSInteger)fromIndex
        toIndex:(NSInteger)toIndex;

@end
