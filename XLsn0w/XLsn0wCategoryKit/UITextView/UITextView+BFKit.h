
@import Foundation;
@import UIKit;

#import "UIFont+BFKit.h"

/**
 *  This category adds some useful methods to UITextView
 */
@interface UITextView (BFKit)

/**
 *  Create an UITextView and set some parameters
 *
 *  @param frame                         TextView's frame
 *  @param text                          TextView's text
 *  @param color                         TextView's text color
 *  @param fontName                      TextView's text font
 *  @param size                          TextView's text size
 *  @param alignment                     TextView's text alignment
 *  @param dataDetectorTypes             TextView's data detector types
 *  @param editable                      Set if TextView is editable
 *  @param selectable                    Set if TextView is selectable
 *  @param returnType                    TextField's return key type
 *  @param keyboardType                  TextField's keyboard type
 *  @param secure                        Set if the TextField is secure or not
 *  @param capitalization                TextField's text capitalization
 *  @param keyboardAppearence            TextField's keyboard appearence
 *  @param enablesReturnKeyAutomatically Set if the TextField has to automatically enables the return key
 *  @param autoCorrectionType            TextField's auto correction type
 *  @param delegate                      TextField's delegate. Set nil if it has no delegate
 *
 *  @return Returns the created UITextView
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                                  text:(NSString * _Nonnull)text
                                 color:(UIColor * _Nonnull)color
                                  font:(FontName)fontName
                                  size:(float)size
                             alignment:(NSTextAlignment)alignment
                     dataDetectorTypes:(UIDataDetectorTypes)dataDetectorTypes
                              editable:(BOOL)editable
                            selectable:(BOOL)selectable
                            returnType:(UIReturnKeyType)returnType
                          keyboardType:(UIKeyboardType)keyboardType
                                secure:(BOOL)secure
                    autoCapitalization:(UITextAutocapitalizationType)capitalization
                    keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence
         enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
                    autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType
                              delegate:(id<UITextViewDelegate> _Nullable)delegate;

@end
