
@import Foundation;
@import UIKit;

#import "UIFont+BFKit.h"

/**
 *  This category adds some useful methods to UITextField
 */
@interface UITextField (BFKit)

/**
 *  Create an UITextField and set some parameters
 *
 *  @param frame                         TextField's frame
 *  @param placeholder                   TextField's text placeholder
 *  @param color                         TextField's text color
 *  @param fontName                      TextField's text font
 *  @param size                          TextField's text size
 *  @param returnType                    TextField's return key type
 *  @param keyboardType                  TextField's keyboard type
 *  @param secure                        Set if the TextField is secure or not
 *  @param borderStyle                   TextField's border style
 *  @param capitalization                TextField's text capitalization
 *  @param keyboardAppearence            TextField's keyboard appearence
 *  @param enablesReturnKeyAutomatically Set if the TextField has to automatically enables the return key
 *  @param clearButtonMode               TextField's clear button mode
 *  @param autoCorrectionType            TextField's auto correction type
 *  @param delegate                      TextField's delegate. Set nil if it has no delegate
 *
 *  @return Returns the created UITextField
 */
+ (instancetype _Nonnull)initWithFrame:(CGRect)frame
                           placeholder:(NSString * _Nonnull)placeholder
                                 color:(UIColor * _Nonnull)color
                                  font:(FontName)fontName
                                  size:(float)size
                            returnType:(UIReturnKeyType)returnType
                          keyboardType:(UIKeyboardType)keyboardType
                                secure:(BOOL)secure
                           borderStyle:(UITextBorderStyle)borderStyle
                    autoCapitalization:(UITextAutocapitalizationType)capitalization
                    keyboardAppearance:(UIKeyboardAppearance)keyboardAppearence
         enablesReturnKeyAutomatically:(BOOL)enablesReturnKeyAutomatically
                       clearButtonMode:(UITextFieldViewMode)clearButtonMode
                    autoCorrectionType:(UITextAutocorrectionType)autoCorrectionType
                              delegate:(id<UITextFieldDelegate> _Nullable)delegate;

@end
