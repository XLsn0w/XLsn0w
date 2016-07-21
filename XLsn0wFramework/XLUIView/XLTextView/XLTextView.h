
#import <UIKit/UIKit.h>

@interface XLTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;

@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat topMargin;
@property (nonatomic, assign) CGFloat placeHeight;

@end
