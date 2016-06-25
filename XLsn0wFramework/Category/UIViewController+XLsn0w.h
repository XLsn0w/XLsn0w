
#import <UIKit/UIKit.h>

@interface UIViewController (XLsn0w)

@end

/**
 *  @author XLsn0w, 06-01
 *
 *  UIViewController HandleNavBack Delegate
 */
@protocol UIViewControllerHandleNavBackDelegate <NSObject>

- (BOOL)clickNavigationBackButtonShouldPopAction;

@end
/**
 *  @author XLsn0w, 06-01
 *
 *  UIViewController Category
 */
@interface UIViewController (HandleNavBack) <UIViewControllerHandleNavBackDelegate>

@end
/**
 *  @author XLsn0w, 06-01
 *
 *  UINavigationController Category
 */
@interface UINavigationController (HandleNavBack)

@end