
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ComboBoxView;

@protocol ComboBoxViewDelegate <NSObject>

@optional
- (void)expandedComboBoxView:(ComboBoxView *)comboBoxView;
- (void)collapseComboBoxView:(ComboBoxView *)comboBoxView;

@required
- (void)selectedItemAtIndex:(NSInteger)selectedIndex fromComboBoxView:(ComboBoxView *)comboBoxView;

@end



@interface ComboBoxView : UIView

@property (nonatomic, assign) id<ComboBoxViewDelegate> xlDelegate;

#pragma mark - Custom Methods

- (void)setShouldShowComboBoxBorder:(BOOL)showComboBoxBorder;     // Default Visible.

- (void)setComboBoxBorderColor:(UIColor *)color;

- (void)setTitleColor:(UIColor *)color;

- (void)setTitleFont:(UIFont *)font;

- (void)setPromptMessage:(NSString *)message;

- (void)setShouldShowDropIndicator:(BOOL)showDropIndicator;     // Default Visible.

- (void)setDropIndicatorImage:(UIImage *)dropIndicatorImage;

/*
    This method is used to set the items which combo box can show.
 
@comboItems: NSArray of NSString objects.
 */
- (void)updateWithAvailableComboBoxItems:(NSArray *)comboItems;

/*
    This method should be should be called after setting the comboBoxItems and the index beyound range will be reset to first index.
*/
- (void)updateWithSelectedIndex:(NSInteger)selectedIndex;

- (void)updateForViewFrameChanged;

- (void)collapseComboBoxView;

- (void)setMaxComboBoxHeight:(CGFloat)maxHeight;

@end
