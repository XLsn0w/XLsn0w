
#import <UIKit/UIKit.h>

@protocol XLSelectSheetDelegate <NSObject>

- (void)selectComplete;

@end

@interface XLSelectSheet : UIView

@property (nonatomic, weak) id<XLSelectSheetDelegate> selectSheetDelegate;

@property (nonatomic, strong) UIToolbar *toolbar;
@property (nonatomic,strong) UIView *backView;

- (instancetype)initWithPickerView:(UIPickerView *)pickerView height:(float)height;

- (void)showInSuperview:(UIView *)view;

@end
